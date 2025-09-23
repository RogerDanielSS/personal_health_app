import './dynamic_field.dart';

class CategoryEntity {
  final int id;
  final String name;
  final String color;
  final bool? allowAttachments;
  final List<DynamicFieldEntity>? dynamicFields;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.color,
    required this.allowAttachments,
    required this.dynamicFields,
  });

  List<Object?> get props => [id, name, dynamicFields, color, allowAttachments];

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'color': color,
        'allowAttachments': allowAttachments,
        'dynamicFields': dynamicFields,
      };
}
