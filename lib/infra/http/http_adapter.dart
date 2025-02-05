import 'dart:convert';
import 'package:http/http.dart';
import 'package:personal_health_app/data/protocols/http/http_error.dart';

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
    bool? convertToSnakeCase = true,
  }) async {
    final defaultHeaders = headers?.cast<String, String>() ?? {}
      ..addAll({'content-type': 'application/json', 'accept': 'application/json'});

    String? jsonBody;
    if (body != null && (requestIsFile == null || requestIsFile == false)) {
      if (convertToSnakeCase == true) {
        final snakedCaseBody = deepKeyTransform(body, camelToSnake);
        jsonBody = jsonEncode(snakedCaseBody);
      } else {
        jsonBody = jsonEncode(body);
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
          futureResponse = client.post(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
        } else {
          futureFileResponse =
              _uploadFileRequest(url: url, headers: defaultHeaders, body: body!, method: method);
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
          futureResponse = client.put(Uri.parse(url), headers: defaultHeaders, body: jsonBody);
        } else {
          futureFileResponse =
              _uploadFileRequest(url: url, headers: defaultHeaders, body: body!, method: method);
        }
      } else if (method == 'delete') {
        futureResponse = client.delete(Uri.parse(url), headers: defaultHeaders);
      }

      if (futureResponse != null) {
        response = await futureResponse.timeout(const Duration(seconds: 180));
      } else if (futureFileResponse != null) {
        fileResponse = await futureFileResponse.timeout(const Duration(seconds: 180));
      }
    } catch (error) {
      print(error);
      throw HttpError.serverError;
    }

    if (fileResponse != null) {
      String responseBody = await fileResponse.stream.bytesToString();
      return _handleResponse(fileResponse, requestIsFile, responseIsFile, responseBody);
    }

    return _handleResponse(response, requestIsFile, responseIsFile, null);
  }

  Future<StreamedResponse> _uploadFileRequest({
    required String url,
    required Map headers,
    required Map<String, dynamic> body,
    required String method,
  }) async {
    var uri = Uri.parse(url);

    // create multipart request
    var request = MultipartRequest(method, uri);

    for (final entry in headers.entries) {
      request.headers[entry.key] = entry.value;
    }

    late Future<MultipartFile> multipartFile;

    // multipart that takes file
    for (final entry in body.entries) {
      if (entry.value is Map) {
        for (final entryLvl2 in entry.value.entries) {
          multipartFile =
              MultipartFile.fromPath('${entry.key}[${entryLvl2.key}]', entryLvl2.value.path);
        }
      } else {
        multipartFile = MultipartFile.fromPath(entry.key, entry.value.path);
      }
    }

    // add file to multipart
    request.files.add(await multipartFile);

    // send
    return request.send();
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

        final camelCasedBody = deepKeyTransform(jsonDecode(response.body), snakeToCamel);
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
        print(response.statusCode);
        throw HttpError.serverError;
    }
  }
}
