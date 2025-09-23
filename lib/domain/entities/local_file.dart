import 'dart:typed_data';

class LocalFileEntity {
  final Uint8List? bytes;
  final String? fileName;
  final String? filePath;
  final int size;
  
  const LocalFileEntity({
    this.bytes,
    this.fileName,
    this.filePath,
    required this.size,
  });
}