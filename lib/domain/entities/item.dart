class ItemEntity {
  final int? id;
  final int categoryId;
  final String? categoryColor;
  final String title;
  final Map<String, String>? fields;

  const ItemEntity({
    this.id,
    this.categoryColor,
    required this.title,
    required this.categoryId,
    required this.fields,
  });

  List<Object?> get props => [id, title, fields];

  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      id: json['id'],
      categoryId: json['categoryId'],
      categoryColor: json['categoryColor'],
      title: json['title'],
      fields: Map<String, String>.from(json['fields'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'categoryId': categoryId,
        'categoryColor': categoryColor,
        'fields': fields,
      };
}
