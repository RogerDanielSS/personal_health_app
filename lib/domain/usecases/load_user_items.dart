import '../entities/item.dart';

abstract class LoadUserItems {
  Future<List<ItemEntity>> load(int userId);
}
