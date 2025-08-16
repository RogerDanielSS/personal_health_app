import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/cache/cache.dart';

class LocalLoadCurrentCategory implements LoadCurrentCategory {
  final FetchSecureCacheStorage fetchSecureCacheStorage;
  final CacheStorage cacheStorage;

  const LocalLoadCurrentCategory({
    required this.fetchSecureCacheStorage,
    required this.cacheStorage,
  });

  @override
  Future<CategoryEntity> load() async {
    try {
      final currentCategory = await cacheStorage.fetch('user');

      if (currentCategory == null) throw Error();

      return CategoryEntity(
        id: currentCategory['id'],
        name: currentCategory['name'],
        dynamicFields: currentCategory['dynamicFields']
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
