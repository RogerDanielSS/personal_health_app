abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required String method,
    Map<String, dynamic>? body,
    Map? headers,
    Map<String, String>? queryParams,
    bool? responseIsFile,
    bool? requestIsFile,
    bool? skipSnakeCaseConvertion,
  });
}
