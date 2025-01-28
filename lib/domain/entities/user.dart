
class UserEntity {
  final int id;
  final String token;
  final String name;
  final String email;
  final String? avatarUrl;

  List get props => [id, token, name, email, avatarUrl];

  const UserEntity({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    this.avatarUrl,
  });

  Map toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'avatarUrl': avatarUrl,
      };
}
