import 'package:personal_health_app/data/protocols/file_selector/file_selector_client.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';
import 'package:personal_health_app/domain/usecases/select_many_files.dart';

class SelectManyFiles implements SelectFiles {
  final FileSelectorClient fileSelector;

  SelectManyFiles({required this.fileSelector});

  @override
  Future<List<LocalFileEntity>> select(
      FileType? type, List<String>? extensions) {
    return fileSelector.selectMany(extensions: extensions, type: type);
  }
}
