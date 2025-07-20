import 'package:personal_health_app/domain/entities/item.dart';

import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../models/remote_event_model.dart';
import '../../protocols/http/http.dart';

class RemoteLoadUserItems implements LoadUserItems {
  final HttpClient httpClient;
  final String url;

  RemoteLoadUserItems({required this.httpClient, required this.url});

  @override
  Future<List<ItemEntity>> load(int userId) async {
    final fullUrl = url.replaceFirst(RegExp(r':user_id'), '$userId');

    try {
      final httpResponse = await httpClient.request(url: fullUrl, method: 'get');
      final responseBody = httpResponse['body'];

      return responseBody
          .map<ItemEntity>((json) => RemoteItemModel.fromJson(json).toEntity())
          .toList();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
