import '../../domain/entities/entities.dart';

abstract class CreateItem {
  Future<ItemEntity> create(ItemEntity  item);
}
