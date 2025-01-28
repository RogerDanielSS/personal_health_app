import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../infra/cache/secure_storage_adapter.dart';

SecureStorageAdapter makeSecureStorageAdapter() {
  const secureStorage = FlutterSecureStorage();
  return SecureStorageAdapter(secureStorage: secureStorage);
}
