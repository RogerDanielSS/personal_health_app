import '../../domain/entities/entities.dart';

abstract class LoadCurrentCategory {
  Future<CategoryEntity> load();
}
