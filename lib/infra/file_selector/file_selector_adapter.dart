import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:personal_health_app/data/protocols/file_selector/file_selector_client.dart';
import 'package:personal_health_app/data/protocols/file_selector/http_error.dart';

class FileSelectorAdapter implements FileSelectorClient {
  @override
  Future<Uint8List> select({String? type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result == null) throw FileSelectorError.noFileSelected;

    PlatformFile file = result.files.first;

    if (file.bytes == null) throw FileSelectorError.noFileSelected;

    return file.bytes!;
  }

  @override
  Future<List<Uint8List>> selectMany({String? type}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
      withData: true,
    );

    if (result == null) throw FileSelectorError.noFileSelected;

    List<Uint8List> filesBytes = result.files
        .map((platformFile) => platformFile.bytes)
        .whereType<
            Uint8List>() // Ensures only non-null Uint8List values are kept
        .toList();

    return filesBytes;
  }
}
