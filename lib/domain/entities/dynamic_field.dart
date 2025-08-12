class DynamicFieldEntity {
  final int id;
  final String name;
  final String dataType;

  const DynamicFieldEntity({
    required this.id,
    required this.name,
    required this.dataType,
  });

  List<Object?> get props => [id, name, dataType];

  factory DynamicFieldEntity.fromJson(Map<String, dynamic> json) {
    return DynamicFieldEntity(
      id: json['id'],
      name: json['name'],
      dataType: json['data_type'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'data_type': dataType,
      };
}
