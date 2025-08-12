import '../../../../domain/usecases/usecases.dart';
import '../../../data/usecases/load_items/remote_load_user_items.dart';
import '../factories.dart';

LoadUserItems makeRemoteLoadItems() => RemoteLoadUserItems(
    httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('users/:user_id/categories'));
