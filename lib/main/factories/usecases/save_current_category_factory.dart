import 'package:personal_health_app/data/usecases/usecases.dart';
import 'package:personal_health_app/main/factories/cache/local_storage_adapter_factory.dart';

import '../../../../domain/usecases/usecases.dart';


SaveCurrentCategory makeLocalSaveCurrentCategory() {
  return LocalSaveCurrentCategory(cacheStorage: makeLocalStorageAdapter());
}
