import 'package:personal_health_app/main/factories/cache/local_storage_adapter_factory.dart';
import 'package:personal_health_app/main/factories/cache/secure_storage_adapter_factory.dart';

import '../../../domain/usecases/usecases.dart';

import '../../../data/usecases/usecases.dart';

DeleteCurrentAccount makeLocalDeleteCurrentAccount() => LocalDeleteCurrentAccount(
      cacheStorage: makeLocalStorageAdapter(),
      deleteSecureCacheStorage: makeSecureStorageAdapter(),
    );
