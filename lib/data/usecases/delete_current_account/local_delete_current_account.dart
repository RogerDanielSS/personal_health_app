import 'package:personal_health_app/data/protocols/cache/cache_storage.dart';
import 'package:personal_health_app/data/protocols/cache/delete_secure_cache_storage.dart';
import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/usecases/usecases.dart';

class LocalDeleteCurrentAccount implements DeleteCurrentAccount {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;
  final CacheStorage cacheStorage;

  const LocalDeleteCurrentAccount(
      {required this.deleteSecureCacheStorage, required this.cacheStorage});

  @override
  Future<void> delete() async {
    try {
      await deleteSecureCacheStorage.delete('token');
      await cacheStorage.delete('user');
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
