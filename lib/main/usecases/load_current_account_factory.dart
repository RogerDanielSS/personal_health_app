import 'package:personal_health_app/data/usecases/load_current_account/local_load_current_account.dart';
import 'package:personal_health_app/main/factories/cache/local_storage_adapter_factory.dart';
import 'package:personal_health_app/main/factories/cache/secure_storage_adapter_factory.dart';


import '../../../domain/usecases/usecases.dart';

LoadCurrentAccount makeLocalLoadCurrentAccount() {
  return LocalLoadCurrentAccount(
      fetchSecureCacheStorage: makeSecureStorageAdapter(), cacheStorage: makeLocalStorageAdapter());
}
