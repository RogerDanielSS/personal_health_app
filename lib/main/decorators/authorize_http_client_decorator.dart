

import '../../data/protocols/cache/delete_secure_cache_storage.dart';
import '../../data/protocols/cache/fetch_secure_cache_storage.dart';
import '../../data/protocols/http/http_client.dart';
import '../../data/protocols/http/http_error.dart';

class AuthorizeHttpClientDecorator implements HttpClient {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final HttpClient decoratee;

  AuthorizeHttpClientDecorator({
    required this.fetchSecureCacheStorage,
    required this.deleteSecureCacheStorage,
    required this.decoratee,
  });

  @override
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map? headers,
    Map<String, String>? queryParams,
    bool? requestIsFile,
    bool? responseIsFile,
    bool? skipSnakeCaseConvertion,
  }) async {
    try {
      final token = await fetchSecureCacheStorage.fetch('token');

      final authorizedHeaders = headers ?? {}
        ..addAll({'authorization': "Bearer $token"});

      return await decoratee.request(
        headers: authorizedHeaders,
        url: url,
        method: method,
        body: body,
        queryParams: queryParams,
        requestIsFile: requestIsFile,
        responseIsFile: responseIsFile,
        skipSnakeCaseConvertion: skipSnakeCaseConvertion
      );
    } catch (error) {
      if (error is HttpError && error != HttpError.forbidden) {
        rethrow;
      } else {
        await deleteSecureCacheStorage.delete('token');
        throw HttpError.forbidden;
      }
    }
  }
}
