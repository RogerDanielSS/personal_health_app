class ItemEntity {
  final int id;
  final String title;
  final Map<String, String> fields;

  const ItemEntity({
    required this.id,
    required this.title,
    required this.fields,
  });

  List<Object?> get props => [id, title, fields];

  factory ItemEntity.fromJson(Map<String, dynamic> json) {
    return ItemEntity(
      id: json['id'],
      title: json['title'],
      fields: Map<String, String>.from(json['fields'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'fields': fields,
      };
}
