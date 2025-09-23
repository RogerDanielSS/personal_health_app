import 'package:personal_health_app/domain/entities/entities.dart';

import '../protocols/http/http_error.dart';

class RemoteCategoryModel {
  final int id;
  final String name;
  final String color;
  final bool? allowAttachments;
  final List<DynamicFieldEntity>? dynamicFields;

  RemoteCategoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.allowAttachments,
    required this.dynamicFields,
  });

  factory RemoteCategoryModel.fromJson(Map json) {
    if (!json.keys.toSet().containsAll(['id', 'name', 'dynamicFields', 'color', 'allowAttachments'])) {
      throw HttpError.invalidData;
    }

    return RemoteCategoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      allowAttachments: json['allowAttachments'],
      dynamicFields: json['dynamicFields'] != null
          ? (json['dynamicFields'] as List)
              .map((fieldJson) => DynamicFieldEntity.fromJson(fieldJson))
              .toList()
          : null,
    );
  }

  CategoryEntity toEntity() => CategoryEntity(
        id: id,
        name: name,
        color: color,
        allowAttachments: allowAttachments,
        dynamicFields: dynamicFields,
      );
}
