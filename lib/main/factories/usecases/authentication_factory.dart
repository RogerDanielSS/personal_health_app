import '../../../../domain/usecases/authentication.dart';

import '../../../../data/usecases/usecases.dart';
import '../http/http.dart';

Authentication makeRemoteAuthentication() {
  return RemoteAuthentication(httpClient: makeHttpAdapter(), url: makeApiUrl('users/sign_in'));
}
