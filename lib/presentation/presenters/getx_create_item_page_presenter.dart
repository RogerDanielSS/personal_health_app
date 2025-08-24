import 'package:get/get.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/pages/create_item/create_item_page_presenter.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxCreateItemPagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements CreateItemPagePresenter {
  final LoadCurrentCategory loadCurrentCategory;
  final CreateItem createItem;

  final _category = Rx<CategoryEntity?>(null);

  GetxCreateItemPagePresenter({required this.loadCurrentCategory, required this.createItem});

  @override
  Stream<CategoryEntity?> get currentCategoryStream => _category.stream;

  @override
  Future<void> loadCurrentCategoryData() async {
    try {
      final currentCategory = await loadCurrentCategory.load();
      if (currentCategory == null) {
        throw DomainError.unexpected;
      }
      _category.value = currentCategory;
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> createItemData(int categoryId, Map<String, String> fields) async {
    try {
      final item = ItemEntity(title: 'title', categoryId: categoryId, fields: fields);
      await createItem.create(item);
    } on Error {
      mainError = UIError.unexpected;
    }
  }
}
