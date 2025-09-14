import 'package:personal_health_app/domain/entities/item.dart';

import '../protocols/http/http_error.dart';

class RemoteItemModel {
  final int id;
  final int categoryId;
  final String categoryColor;
  final String title;
  final Map<String, String> fields;

  RemoteItemModel({
    required this.id,
    required this.categoryId,
    required this.categoryColor,
    required this.title,
    required this.fields,
  });

  factory RemoteItemModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'categoryId', 'categoryColor', 'title', 'fields'])) {
      throw HttpError.invalidData;
    }

    return RemoteItemModel(
      id: json['id'],
      categoryId: json['categoryId'],
      categoryColor: json['categoryColor'],
      title: json['title'],
      fields: Map<String, String>.from(json['fields']),
    );
  }

  ItemEntity toEntity() => ItemEntity(
        id: id,
        categoryId: categoryId,
        categoryColor: categoryColor,
        title: title,
        fields: fields,
      );
}
