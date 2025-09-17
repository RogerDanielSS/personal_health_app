import 'dart:typed_data';

abstract class SelectFile {
  Future<Uint8List> select();
}
