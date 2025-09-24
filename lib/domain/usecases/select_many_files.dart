import 'package:personal_health_app/data/protocols/file_selector/file_selector_client.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class SelectFiles {
  Future<List<LocalFileEntity>> select(
      FileType? type, List<String>? extensions);
}
