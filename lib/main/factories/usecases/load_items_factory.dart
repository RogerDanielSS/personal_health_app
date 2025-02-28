import '../../../../domain/usecases/usecases.dart';
import '../../../data/usecases/load_items/remote_load_items.dart';
import '../factories.dart';

LoadItems makeRemoteLoadItems() => RemoteLoadItems(
    httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('items'));
