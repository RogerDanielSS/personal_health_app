import 'dart:typed_data';

class LocalFileEntity {
  final Uint8List? bytes;
  final String? name;
  final String? path;
  final int size;

  const LocalFileEntity({
    this.bytes,
    this.name,
    this.path,
    required this.size,
  });
}
