import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/cache/cache.dart';

class LocalSaveCurrentAccount implements SaveCurrentAccount {
  SaveSecureCacheStorage saveSecureCacheStorage;
  final CacheStorage cacheStorage;

  LocalSaveCurrentAccount({required this.saveSecureCacheStorage, required this.cacheStorage});

  @override
  Future<void> save(UserEntity user) async {
    try {
      await saveSecureCacheStorage.saveSecure(key: 'token', value: user.token);
      await cacheStorage.save(key: 'user', value: user.toJson());
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
