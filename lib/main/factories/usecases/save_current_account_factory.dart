import 'package:personal_health_app/data/usecases/save_current_account/local_save_current_account.dart';
import 'package:personal_health_app/main/factories/cache/local_storage_adapter_factory.dart';
import 'package:personal_health_app/main/factories/cache/secure_storage_adapter_factory.dart';

import '../../../../domain/usecases/usecases.dart';


SaveCurrentAccount makeLocalSaveCurrentAccount() {
  return LocalSaveCurrentAccount(
      saveSecureCacheStorage: makeSecureStorageAdapter(), cacheStorage: makeLocalStorageAdapter());
}
