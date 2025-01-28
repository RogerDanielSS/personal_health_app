import '../../domain/entities/entities.dart';
import '../protocols/http/http_error.dart';

class RemoteUserModel {
  final int id;
  final String token;
  final String name;
  final String email;
  final String? avatarUrl;
  
  RemoteUserModel({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  factory RemoteUserModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'token', 'name', 'phoneNumber'])) {
      throw HttpError.invalidData;
    }

    return RemoteUserModel(
      id: json['id'],
      token: json['token'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
    );
  }

  UserEntity toEntity() => UserEntity(
        id: id,
        token: token,
        name: name,
        email: email,
        avatarUrl: avatarUrl,
      );
}
