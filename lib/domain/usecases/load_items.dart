import '../entities/item.dart';

abstract class LoadItems {
  Future<List<ItemEntity>> load();
}
