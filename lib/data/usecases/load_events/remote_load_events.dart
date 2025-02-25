import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../models/remote_event_model.dart';
import '../../protocols/http/http.dart';

class RemoteLoadEvents implements LoadEvents {
  final HttpClient httpClient;
  final String url;

  RemoteLoadEvents({required this.httpClient, required this.url});

  @override
  Future<List<EventEntity>> load() async {
    // final fullUrl = url.replaceFirst(RegExp(r':teamId'), '$teamId');

    try {
      final httpResponse = await httpClient.request(url: url, method: 'get');
      final responseBody = httpResponse['body'];
      return responseBody
          .map<EventEntity>(
              (json) => RemoteEventModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
