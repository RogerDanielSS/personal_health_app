import 'package:personal_health_app/domain/entities/entities.dart';

import '../../../domain/helpers/domain_error.dart';
import '../../../domain/usecases/usecases.dart';

import '../../models/remote_category_model.dart';
import '../../protocols/http/http.dart';

class RemoteLoadUserCategories implements LoadUserCategories {
  final HttpClient httpClient;
  final String url;

  RemoteLoadUserCategories({required this.httpClient, required this.url});

  @override
  Future<List<CategoryEntity>> load(int userId) async {
    final fullUrl = url.replaceFirst(RegExp(r':user_id'), '$userId');

    try {
      final httpResponse =
          await httpClient.request(url: fullUrl, method: 'get');
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
