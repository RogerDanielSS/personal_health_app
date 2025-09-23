import 'package:personal_health_app/domain/helpers/domain_error.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/cache/cache.dart';

class LocalLoadCurrentCategory implements LoadCurrentCategory {
  final CacheStorage cacheStorage;

  const LocalLoadCurrentCategory({
    required this.cacheStorage,
  });

  @override
  Future<CategoryEntity> load() async {
    try {
      final currentCategory = await cacheStorage.fetch('category');

      if (currentCategory == null) throw Error();

      return CategoryEntity(
        id: currentCategory['id'],
        name: currentCategory['name'],
        color: currentCategory['color'],
        allowAttachments: currentCategory['allowAttachments'],
        dynamicFields: currentCategory['dynamicFields']
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
