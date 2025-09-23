import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class SelectFile {
  Future<LocalFileEntity> select();
}
