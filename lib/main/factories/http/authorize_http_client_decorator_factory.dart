
import '../../../data/protocols/http/http_client.dart';
import '../../decorators/decorators.dart';
import '../factories.dart';

HttpClient makeAuthorizeHttpClientDecorator() => AuthorizeHttpClientDecorator(
      decoratee: makeHttpAdapter(),
      fetchSecureCacheStorage: makeSecureStorageAdapter(),
      deleteSecureCacheStorage: makeSecureStorageAdapter(),
    );
