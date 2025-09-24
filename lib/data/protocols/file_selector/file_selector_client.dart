import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class FileSelectorClient {
  Future<LocalFileEntity> select({
    FileType? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });

  Future<List<LocalFileEntity>> selectMany({
    FileType? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });
}

enum FileType { image, video, audio, document, any }
