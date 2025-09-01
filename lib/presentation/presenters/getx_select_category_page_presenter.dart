import 'package:get/get.dart';
import 'package:personal_health_app/UI/pages/select_category/select_category.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxSelectCategoryPagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements SelectCategoryPagePresenter {
  final LoadUserCategories loadCategories;
  final LoadCurrentAccount loadCurrentAccount;
  final SaveCurrentCategory saveCurrentCategory;

  final _categories = Rx<List<CategoryEntity>>([]);
  final _categoriesError = Rx<String>('');

  GetxSelectCategoryPagePresenter(
      {required this.loadCategories,
      required this.loadCurrentAccount,
      required this.saveCurrentCategory});

  @override
  Stream<List<CategoryEntity>> get categoriesStream => _categories.stream;

  @override
  Future<void> loadCategoriesData() async {
    try {
      mainError = null;
      _categoriesError.value = '';

      final account = await loadCurrentAccount.load();

      final categories = await loadCategories.load(account.id);
      _categories.value = categories;
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        setCategoryError();
      }
    } on Error {
      setCategoryError();
    }
  }

  @override
  Future<void> saveCategory(CategoryEntity category) async {
    try {
      mainError = null;
      _categoriesError.value = '';

      await saveCurrentCategory.save(category);

    } on Error {
      mainError = UIError.unexpected;
    }
  }

  void setCategoryError() {
    _categoriesError.value = UIError.unexpected.description;
    _categories.refresh();
  }
}
