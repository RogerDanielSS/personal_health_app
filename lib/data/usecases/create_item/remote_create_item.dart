import 'package:personal_health_app/domain/entities/entities.dart';

import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../models/remote_category_model.dart';
import '../../protocols/http/http.dart';

class RemoteCreateItem implements CreateItem {
  final HttpClient httpClient;
  final String url;

  RemoteCreateItem({required this.httpClient, required this.url});

  @override
  Future<ItemEntity> create(ItemEntity item) async {
    final body = {
        'title': item.title,
        'category_id': item.categoryId,
        'fields': item.fields,
      };;

    try {
      final httpResponse =
          await httpClient.request(url: url, method: 'post', body: body);
      final responseBody = httpResponse['body'];

      final entityList = responseBody
          .map<CategoryEntity>(
              (json) => RemoteCategoryModel.fromJson(json).toEntity())
          .toList();

      return entityList;
    } on HttpError catch (error) {
      throw error == HttpError.unauthorized
          ? DomainError.accessDenied
          : DomainError.unexpected;
    }
  }
}
