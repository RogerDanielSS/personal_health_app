
import '../entities/user.dart';

abstract class Authentication {
  Future<UserEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String password;

  List get props => [email, password];

  const AuthenticationParams({required this.email, required this.password});
}
