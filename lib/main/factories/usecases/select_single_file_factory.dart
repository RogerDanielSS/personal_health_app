import 'package:personal_health_app/data/usecases/select_file/select_single_file.dart';
import 'package:personal_health_app/main/factories/file_selector/file_selector_adapter_factory.dart';

import '../../../../domain/usecases/usecases.dart';

SelectFile makeSelectSingleFile() {
  return SelectSingleFile(fileSelector: makeFileSelectorAdapter());
}
