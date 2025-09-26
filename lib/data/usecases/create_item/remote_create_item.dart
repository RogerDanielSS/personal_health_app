import 'package:personal_health_app/data/models/remote_item_model.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../protocols/http/http.dart';

class RemoteCreateItem implements CreateItem {
  final HttpClient httpClient;
  final String url;

  RemoteCreateItem({required this.httpClient, required this.url});

  @override
  Future<ItemEntity> create(ItemEntity item) async {
    final body = {
      "item": {
        'title': item.title,
        'category_id': item.categoryId,
        'fields': item.fields,
        'images': item.images
      }
    };

    try {
      final httpResponse = await httpClient.request(
          url: url,
          method: 'post',
          requestIsFile: true,
          body: body,
          skipSnakeCaseConvertion: true);
      final responseBody = httpResponse['body'];

      return RemoteItemModel.fromJson(responseBody).toEntity();
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
