import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class FileSelectorClient {
  Future<LocalFileEntity> select({
    String? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });

  Future<List<LocalFileEntity>> selectMany({
    String? type,
    List<String>? extensions,
    bool preloadBytes = true,
  });
}
