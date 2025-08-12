import 'package:personal_health_app/domain/entities/entities.dart';

import '../protocols/http/http_error.dart';

class RemoteCategoryModel {
  final int id;
  final String title;
  final List<DynamicFieldEntity>? fields;

  RemoteCategoryModel({
    required this.id,
    required this.title,
    required this.fields,
  });

  factory RemoteCategoryModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'title', 'fields'])) {
      throw HttpError.invalidData;
    }

    return RemoteCategoryModel(
      id: json['id'],
      title: json['title'],
      fields: json['fields'] != null
          ? (json['fields'] as List)
              .map((fieldJson) => DynamicFieldEntity.fromJson(fieldJson))
              .toList()
          : null,
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        title: title,
        fields: fields,
      );
}
