import 'package:personal_health_app/domain/entities/local_file.dart';

class ItemEntity {
  final int? id;
  final int categoryId;
  final String? categoryColor;
  final String? title;
  final Map<String, String>? fields;
  final List<LocalFileEntity>? images;

  const ItemEntity({
    this.id,
    this.categoryColor,
    this.images,
    this.title,
    required this.categoryId,
    required this.fields,
  });

  List<Object?> get props => [id, title, fields, images];

  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      id: json['id'],
      categoryId: json['categoryId'],
      categoryColor: json['categoryColor'],
      title: json['title'],
      images: json['images'],
      fields: Map<String, String>.from(json['fields'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'categoryId': categoryId,
        'categoryColor': categoryColor,
        'fields': fields,
        'images': images,
      };
}
