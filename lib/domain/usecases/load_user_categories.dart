import 'package:personal_health_app/domain/entities/entities.dart';

abstract class LoadUserCategories {
  Future<List<CategoryEntity>> load(int userId);
}
