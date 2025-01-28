

import '../../../domain/entities/user.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/authentication.dart';
import '../../models/remote_user_model.dart';
import '../../protocols/http/http_client.dart';
import '../../protocols/http/http_error.dart';

class RemoteAuthentication implements Authentication {
  final HttpClient httpClient;
  final String url;

  RemoteAuthentication({required this.httpClient, required this.url});

  @override
  Future<UserEntity> auth(AuthenticationParams params) async {
    final body = RemoteAuthenticationParams.fromDomain(params).toJson();

    try {
      final httpResponse = await httpClient.request(url: url, method: 'post', body: body);
      final responseBody = httpResponse['body'];
      final token = httpResponse['headers']['authorization'].split(' ')[1];

      final userModel = {
        'id': responseBody['id'],
        'token': token,
        'name': responseBody['name'],
        'email': responseBody['email'],
        'phoneNumber': responseBody['phoneNumber'],
        'avatarUrl': responseBody['avatarUrl'],
        'partnerCompanyId': responseBody['partnerCompanyId'],
        'roles': responseBody['roles'],
      };

      return RemoteUserModel.fromJson(userModel).toEntity();
    } on HttpError catch (error) {
      switch (error) {
        case HttpError.forbidden:
        case HttpError.unauthorized:
          throw DomainError.invalidCredentials;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}

class RemoteAuthenticationParams {
  final String email;
  final String password;

  RemoteAuthenticationParams({required this.email, required this.password});

  factory RemoteAuthenticationParams.fromDomain(AuthenticationParams params) =>
      RemoteAuthenticationParams(email: params.email, password: params.password);

  Map<String, dynamic> toJson() => {
        'user': {'email': email, 'password': password}
      };
}
