import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/cache/cache.dart';

class LocalSaveCurrentCategory implements SaveCurrentCategory {
  SaveSecureCacheStorage saveSecureCacheStorage;
  final CacheStorage cacheStorage;

  LocalSaveCurrentCategory({required this.saveSecureCacheStorage, required this.cacheStorage});

  @override
  Future<void> save(CategoryEntity category) async {
    try {
      await cacheStorage.save(key: 'category', value: category.toJson());
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
