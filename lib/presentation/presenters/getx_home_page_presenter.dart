import 'package:get/get.dart';

import 'package:personal_health_app/domain/entities/item.dart';
import 'package:personal_health_app/presentation/pages/home_page_presenter.dart';

import '../../../domain/usecases/usecases.dart';
import '../../domain/helpers/domain_error.dart';
import '../helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxHomePagePresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements HomePagePresenter {
  final LoadItems loadItems;
  final DeleteCurrentAccount deleteCurrentAccount;
  final LoadCurrentAccount loadCurrentAccount;

  final _items = Rx<List<ItemEntity>>([]);
  final _itemsError = Rx<String>('');
  final _selectedItem = Rx<ItemEntity?>(null);

  GetxHomePagePresenter({
    required this.loadItems,
    required this.deleteCurrentAccount,
    required this.loadCurrentAccount,
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

      final items = await loadItems.load();
      _items.value = items
          .map((item) =>
              ItemEntity(id: item.id, title: item.title, fields: item.fields))
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
}
