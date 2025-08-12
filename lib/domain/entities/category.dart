import './dynamic_field.dart';

class CategoryEntity {
  final int id;
  final String title;
  final List<DynamicFieldEntity>? fields;

  const CategoryEntity({
    required this.id,
    required this.title,
    required this.fields,
  });

  List<Object?> get props => [id, title, fields];

  factory CategoryEntity.fromJson(Map<String, dynamic> json) {
    return CategoryEntity(
      id: json['id'],
      title: json['title'],
      fields: json['fields'] != null
          ? (json['fields'] as List)
              .map((fieldJson) => DynamicFieldEntity.fromJson(fieldJson))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'fields': fields,
      };
}
