import 'package:get/get.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

import 'package:personal_health_app/domain/entities/item.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxHomePagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements HomePagePresenter {
  final LoadUserItems loadItems;
  final LoadUserCategories loadCategories;
  final DeleteCurrentAccount deleteCurrentAccount;
  final LoadCurrentAccount loadCurrentAccount;
  final SaveCurrentCategory saveCurrentCategory;

  final _items = Rx<List<ItemEntity>>([]);
  final _itemsError = Rx<String>('');
  final _selectedItem = Rx<ItemEntity?>(null);
  final _categories = Rx<List<CategoryEntity>>([]);
  final _categoriesError = Rx<String>('');

  GetxHomePagePresenter({
    required this.loadItems,
    required this.loadCategories,
    required this.deleteCurrentAccount,
    required this.loadCurrentAccount,
    required this.saveCurrentCategory
  });

  @override
  Stream<ItemEntity?> get selectedItemStream => _selectedItem.stream;
  @override
  Stream<List<ItemEntity>> get itemsStream => _items.stream;
  @override
  Stream<List<CategoryEntity>> get categoriesStream => _categories.stream;

  @override
  Future<void> loadItemsData() async {
    try {
      mainError = null;
      _itemsError.value = '';

      final account = await loadCurrentAccount.load();

      final items = await loadItems.load(account.id);
      _items.value = items
          .map((item) =>
              ItemEntity(id: item.id, categoryId: item.categoryId, title: item.title, fields: item.fields))
          .toList();
    } on DomainError catch (error) {
      if (error == DomainError.accessDenied) {
        isSessionExpired = true;
      } else {
        setError();
      }
    } on Error {
      setError();
    }
  }

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

  @override
  Future<void> logout() async {
    try {
      await deleteCurrentAccount.delete();
      navigateTo = '/login';
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  void setError() {
    _itemsError.value = UIError.unexpected.description;
    _items.refresh();
  }
  void setCategoryError() {
    _categoriesError.value = UIError.unexpected.description;
    _categories.refresh();
  }
}
