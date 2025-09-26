import 'dart:convert';
import 'package:http/http.dart';
import 'package:personal_health_app/data/protocols/http/http_error.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

import '../../data/protocols/http/http_client.dart';

import '../helpers/helpers.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter({required this.client});

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map? headers,
    Map<String, String>? queryParams,
    bool? responseIsFile,
    bool? requestIsFile,
    bool? skipSnakeCaseConvertion,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});

    String? jsonBody;
    if (body != null && (requestIsFile == null || requestIsFile == false)) {
      if (skipSnakeCaseConvertion == true) {
        jsonBody = jsonEncode(body);
      } else {
        final snakedCaseBody = deepKeyTransform(body, camelToSnake);
        jsonBody = jsonEncode(snakedCaseBody);
      }
    } else {
      jsonBody = null;
    }

    var response = Response('', 500);
    StreamedResponse? fileResponse;
    Future<Response>? futureResponse;
    Future<StreamedResponse>? futureFileResponse;
    try {
      if (method == 'post') {
        if (requestIsFile == null || requestIsFile == false) {
          futureResponse = client.post(Uri.parse(url),
              headers: defaultHeaders, body: jsonBody);
        } else {
          futureFileResponse = _uploadFileRequest(
              url: url, headers: defaultHeaders, body: body!, method: method);
        }
      } else if (method == 'get') {
        final Uri uri;
        if (queryParams != null) {
          uri = Uri.parse(url).replace(queryParameters: queryParams);
        } else {
          uri = Uri.parse(url);
        }

        futureResponse = client.get(uri, headers: defaultHeaders);
      } else if (method == 'put') {
        if (requestIsFile == null || requestIsFile == false) {
          futureResponse = client.put(Uri.parse(url),
              headers: defaultHeaders, body: jsonBody);
        } else {
          futureFileResponse = _uploadFileRequest(
              url: url, headers: defaultHeaders, body: body!, method: method);
        }
      } else if (method == 'delete') {
        futureResponse = client.delete(Uri.parse(url), headers: defaultHeaders);
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 180));
      } else if (futureFileResponse != null) {
        fileResponse =
            await futureFileResponse.timeout(const Duration(seconds: 180));
      }
    } catch (error) {
      throw HttpError.serverError;
    }

    if (fileResponse != null) {
      String responseBody = await fileResponse.stream.bytesToString();
      return _handleResponse(
          fileResponse, requestIsFile, responseIsFile, responseBody);
    }

    return _handleResponse(response, requestIsFile, responseIsFile, null);
  }

  Future<StreamedResponse> _uploadFileRequest({
    required String url,
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required String method,
  }) async {
    final uri = Uri.parse(url);
    final request = MultipartRequest(method, uri);

    // Set headers
    request.headers.addAll(headers);

    // Recursively process the body and add to request
    _processBodyPart(request, body, parentKey: null);

    return request.send();
  }

  void _processBodyPart(
    MultipartRequest request,
    dynamic value, {
    String? parentKey,
  }) {
    if (value == null) return;

    if (value is LocalFileEntity) {
      // Handle file entity
      _addFileToRequest(request, value, parentKey!);
    } else if (value is Map<String, dynamic>) {
      // Recursively process map entries
      for (final entry in value.entries) {
        final newKey =
            parentKey != null ? '$parentKey[${entry.key}]' : entry.key;
        _processBodyPart(request, entry.value, parentKey: newKey);
      }
    } else if (value is List<dynamic>) {
      // Recursively process list items
      _processList(request, value, parentKey: parentKey);
    } else {
      // Handle simple values (string, number, boolean, etc.)
      _addFieldToRequest(request, value, parentKey!);
    }
  }

  void _processList(
    MultipartRequest request,
    List<dynamic> list, {
    String? parentKey,
  }) {
    if (list.isEmpty) return;

    // Special handling for file arrays - use empty brackets
    if (list.isNotEmpty && list.every((item) => item is LocalFileEntity)) {
      for (final item in list) {
        // Use empty brackets for file arrays (Rails convention)
        final newKey = parentKey != null ? '$parentKey[]' : '[]';
        _addFileToRequest(request, item as LocalFileEntity, newKey);
      }
    } else if (list.isNotEmpty && list.every((item) => item is Map)) {
      // Handle list of maps with indices
      for (int i = 0; i < list.length; i++) {
        final newKey = parentKey != null ? '$parentKey[$i]' : i.toString();
        _processBodyPart(request, list[i], parentKey: newKey);
      }
    } else {
      // Handle mixed or simple value lists with indices
      for (int i = 0; i < list.length; i++) {
        final newKey = parentKey != null ? '$parentKey[$i]' : i.toString();
        _processBodyPart(request, list[i], parentKey: newKey);
      }
    }
  }

  void _addFileToRequest(
    MultipartRequest request,
    LocalFileEntity file,
    String fieldName,
  ) {
    final multipartFile = MultipartFile.fromBytes(
      fieldName,
      file.bytes!,
      filename: file.name,
    );
    request.files.add(multipartFile);
  }

  void _addFieldToRequest(
    MultipartRequest request,
    dynamic value,
    String fieldName,
  ) {
    // Convert value to string representation
    final stringValue = value.toString();
    request.fields[fieldName] = stringValue;
  }

  dynamic _handleResponse(
    dynamic response,
    bool? requestIsFile,
    bool? responseIsFile,
    String? body,
  ) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (responseIsFile == true) {
          return {'headers': response.headers, 'body': response.bodyBytes};
        }

        if (requestIsFile == true) {
          Map<String, dynamic> jsonResponse = json.decode(body!);

          final camelCasedBody = deepKeyTransform(jsonResponse, snakeToCamel);
          return {'headers': response.headers, 'body': camelCasedBody};
        }

        if (response.body.isEmpty) {
          return null;
        }

        final camelCasedBody =
            deepKeyTransform(jsonDecode(response.body), snakeToCamel);
        return {'headers': response.headers, 'body': camelCasedBody};
      case 204:
        return null;
      case 400:
        throw HttpError.badRequest;
      case 401:
        throw HttpError.unauthorized;
      case 403:
        throw HttpError.forbidden;
      case 404:
        throw HttpError.notFound;
      default:
        throw HttpError.serverError;
    }
  }
}
