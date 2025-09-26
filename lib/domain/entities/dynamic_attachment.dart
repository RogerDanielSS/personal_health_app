import 'dart:typed_data';

class DynamicAttachmentEntity {
  final int id;
  final String name;
  final String format;
  final Uint8List? file;

  const DynamicAttachmentEntity({
    required this.id,
    required this.name,
    required this.format,
    this.file,
  });

  List<Object?> get props => [id, name, format, file];

  factory DynamicAttachmentEntity.fromJson(Map<String, dynamic> json) {
    return DynamicAttachmentEntity(
      id: json['id'],
      name: json['name'],
      format: json['format'],
      file: json['file'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'format': format,
        'file': file,
      };
}
