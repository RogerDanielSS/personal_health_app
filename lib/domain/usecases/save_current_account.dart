import '../../domain/entities/entities.dart';

abstract class SaveCurrentAccount {
  Future<void> save(UserEntity account);
}
