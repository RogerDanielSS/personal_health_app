import 'package:personal_health_app/data/protocols/file_selector/file_selector_client.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';
import '../../../domain/usecases/usecases.dart';

class SelectSingleFile implements SelectFile {
  final FileSelectorClient fileSelector;

  SelectSingleFile({required this.fileSelector});

  @override
  Future<LocalFileEntity> select() {
    return fileSelector.select();
  }
}
