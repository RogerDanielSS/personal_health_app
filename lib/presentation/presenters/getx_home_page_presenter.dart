import 'package:get/get.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

import 'package:personal_health_app/UI/pages/home/home_page_presenter.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxHomePagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements HomePagePresenter {
  final LoadUserItems loadItems;
  final LoadCurrentAccount loadCurrentAccount;

  final _items = Rx<List<ItemEntity>>([]);
  final _itemsError = Rx<String>('');
  final _selectedItem = Rx<ItemEntity?>(null);

  GetxHomePagePresenter({
    required this.loadItems,
    required this.loadCurrentAccount
  });

  @override
  Stream<ItemEntity?> get selectedItemStream => _selectedItem.stream;
  @override
  Stream<List<ItemEntity>> get itemsStream => _items.stream;

  @override
  Future<void> loadItemsData() async {
    try {
      mainError = null;
      _itemsError.value = '';

      final account = await loadCurrentAccount.load();

      final items = await loadItems.load(account.id);
      _items.value = items.toList();
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
  Future<void> handleAddNewItem() async {
    try {
      navigateTo = '/items/select_category';
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  void setError() {
    _itemsError.value = UIError.unexpected.description;
    _items.refresh();
  }
}
