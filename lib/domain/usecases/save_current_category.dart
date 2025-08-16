import '../../domain/entities/entities.dart';

abstract class SaveCurrentCategory {
  Future<void> save(CategoryEntity category);
}
