import 'package:get/get.dart';
import 'package:personal_health_app/UI/components/main_layout/main_layout_presenter.dart';
import 'package:personal_health_app/domain/entities/user.dart';
import 'package:personal_health_app/domain/usecases/usecases.dart';
// import 'package:personal_health_app/domain/usecases.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxMainLayoutPresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements MainLayoutPresenter {
  final DeleteCurrentAccount deleteCurrentAccount;
  final LoadCurrentAccount loadCurrentAccount;

  final _currentAccount = Rx<UserEntity?>(null);

  GetxMainLayoutPresenter({required this.deleteCurrentAccount, required this.loadCurrentAccount});

  @override
  Stream<UserEntity?> get currentAccountStream => _currentAccount.stream;

  @override
  Future<void> logout() async {
    try {
      await deleteCurrentAccount.delete();
      navigateTo = '/';
    } on Error {
      mainError = UIError.unexpected;
    }
  }

  @override
  Future<void> loadCurrentAccountData() async {
    try {
      mainError = null;

      final account = await loadCurrentAccount.load();

      _currentAccount.value = account;
    } on Error {
      mainError = UIError.unexpected;
    }
  }
}
