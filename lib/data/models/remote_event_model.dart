import 'package:personal_health_app/domain/entities/item.dart';

import '../protocols/http/http_error.dart';

class RemoteItemModel {
  final int id;
  final String title;
  final Map<String, String> fields;

  RemoteItemModel({
    required this.id,
    required this.title,
    required this.fields,
  });

  factory RemoteItemModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'title', 'column1'])) {
      throw HttpError.invalidData;
    }

    return RemoteItemModel(
      id: json['id'],
      title: json['title'],
      fields: json['fields'],
    );
  }

  ItemEntity toEntity() => ItemEntity(
        id: id,
        title: title,
        fields: fields,
      );
}
