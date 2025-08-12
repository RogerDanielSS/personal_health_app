import './dynamic_field.dart';

class CategoryEntity {
  final int id;
  final String name;
  final List<DynamicFieldEntity>? dynamicFields;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.dynamicFields,
  });

  List<Object?> get props => [id, name, dynamicFields];

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'],
      name: json['name'],
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
        'dynamicFields': dynamicFields,
      };
}
