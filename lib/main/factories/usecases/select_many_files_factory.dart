import 'package:personal_health_app/data/usecases/select_file/select_many_files.dart';
import 'package:personal_health_app/domain/usecases/select_many_files.dart';
import 'package:personal_health_app/main/factories/file_selector/file_selector_adapter_factory.dart';

SelectFiles makeSelectManyFiles() {
  return SelectManyFiles(fileSelector: makeFileSelectorAdapter());
}
