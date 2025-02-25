import '../../../../domain/usecases/usecases.dart';
import '../../../data/usecases/load_events/remote_load_events.dart';
import '../factories.dart';

LoadEvents makeRemoteLoadEvents() => RemoteLoadEvents(
    httpClient: makeAuthorizeHttpClientDecorator(), url: makeApiUrl('events'));
