import 'package:personal_health_app/data/usecases/load_current_category/local_load_current_category.dart';
import 'package:personal_health_app/main/factories/cache/local_storage_adapter_factory.dart';


import '../../../../domain/usecases/usecases.dart';

LoadCurrentCategory makeLocalLoadCurrentCategory() {
  return LocalLoadCurrentCategory(cacheStorage: makeLocalStorageAdapter());
}
