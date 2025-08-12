import 'package:personal_health_app/data/usecases/load_categories/remote_load_user_categories.dart';

import '../../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadUserCategories makeRemoteLoadCategories() => RemoteLoadUserCategories(
    httpClient: makeAuthorizeHttpClientDecorator(),
    url: makeApiUrl('users/:user_id/categories'));
