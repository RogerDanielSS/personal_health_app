import '../../domain/entities/entities.dart';

abstract class LoadEvents {
  Future<List<EventEntity>> load();
}
