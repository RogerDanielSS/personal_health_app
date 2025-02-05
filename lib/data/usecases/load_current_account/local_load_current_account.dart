import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/cache/cache.dart';

class LocalLoadCurrentAccount implements LoadCurrentAccount {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final CacheStorage cacheStorage;

  const LocalLoadCurrentAccount({
    required this.fetchSecureCacheStorage,
    required this.cacheStorage,
  });

  @override
  Future<UserEntity> load() async {
    try {
      final token = await fetchSecureCacheStorage.fetch('token');
      final userWithoutToken = await cacheStorage.fetch('user');

      if (token == null) throw Error();
      if (userWithoutToken == null) throw Error();

      return UserEntity(
        token: token,
        id: userWithoutToken['id'],
        name: userWithoutToken['name'],
        email: userWithoutToken['email'],
        avatarUrl: userWithoutToken['avatarUrl'],
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
