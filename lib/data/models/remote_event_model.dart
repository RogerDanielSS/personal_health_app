import '../../domain/entities/entities.dart';
import '../protocols/http/http_error.dart';

class RemoteEventModel {
  final int id;
  final String title;
  final String column1;

  RemoteEventModel({
    required this.id,
    required this.title,
    required this.column1,
  });

  factory RemoteEventModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'title', 'column1'])) {
      throw HttpError.invalidData;
    }

    return RemoteEventModel(
      id: json['id'],
      title: json['title'],
      column1: json['column1'],
    );
  }

  EventEntity toEntity() => EventEntity(
        id: id,
        title: title,
        column1: column1,
      );
}
