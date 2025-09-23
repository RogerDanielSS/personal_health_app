import 'dart:typed_data';

abstract class FileSelectorClient {
  Future<Uint8List> select({
    String? type
  });

  Future<List<Uint8List>> selectMany({
    String? type
  });
}
