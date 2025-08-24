import 'package:personal_health_app/data/usecases/usecases.dart';

import '../../../../domain/usecases/usecases.dart';
import '../factories.dart';

CreateItem makeRemoteCreateItem() => RemoteCreateItem(
    httpClient: makeAuthorizeHttpClientDecorator(),
    url: makeApiUrl('items'));
