import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class FileSelectorClient {
  Future<LocalFileEntity> select({
    LocalFileType? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });

  Future<List<LocalFileEntity>> selectMany({
    LocalFileType? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });
}

enum LocalFileType { image, video, audio, document, any }
