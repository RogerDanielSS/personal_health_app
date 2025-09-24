import 'package:file_picker/file_picker.dart';
import 'package:personal_health_app/data/protocols/file_selector/file_selector_client.dart'
    hide FileType;
import 'package:personal_health_app/data/protocols/file_selector/file_error.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

class FileSelectorAdapter implements FileSelectorClient {
  @override
  Future<LocalFileEntity> select(
      {LocalFileType? type,
      List<String>? extensions,
      bool preloadBytes = true}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: _mapToFileType(type, extensions),
      withData: preloadBytes,
      allowedExtensions: extensions,
    );

    if (result == null) throw FileError.noFileSelected;

    PlatformFile file = result.files.first;

    if (file.bytes == null) throw FileError.noFileSelected;

    return buildLocalFile(file);
  }

  @override
  Future<List<LocalFileEntity>> selectMany(
      {LocalFileType? type,
      List<String>? extensions,
      bool preloadBytes = true}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: _mapToFileType(type, extensions),
      withData: preloadBytes,
      allowedExtensions: extensions,
    );

    if (result == null) throw FileError.noFileSelected;

    List<LocalFileEntity> filesBytes = result.files
        .map((platformFile) => buildLocalFile(platformFile))
        .whereType<
            LocalFileEntity>() // Ensures only non-null Uint8List values are kept
        .toList();

    return filesBytes;
  }

  LocalFileEntity buildLocalFile(PlatformFile file) {
    return LocalFileEntity(
        size: file.size,
        bytes: file.bytes,
        fileName: file.name,
        filePath: file.path);
  }

  FileType _mapToFileType(LocalFileType? type, List<String>? extensions) {
    if (extensions?.isNotEmpty ?? false) return FileType.custom;

    switch (type) {
      case LocalFileType.image:
        return FileType.image;
      case LocalFileType.video:
        return FileType.video;
      case LocalFileType.audio:
        return FileType.audio;
      case LocalFileType.document:
        return FileType.media;
      case LocalFileType.any:
      default:
        return FileType.any;
    }
  }
}
