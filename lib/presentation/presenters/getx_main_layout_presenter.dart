import 'package:get/get.dart';
import 'package:personal_health_app/UI/components/main_layout/main_layout_presenter.dart';
import 'package:personal_health_app/domain/usecases/delete_current_account.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';
import '../mixins/mixins.dart';

class GetxMainLayoutPresenter extends GetxController
    with SessionManager, NavigationManager, UIErrorManager, LoadingManager
    implements MainLayoutPresenter {
  final DeleteCurrentAccount deleteCurrentAccount;

  GetxMainLayoutPresenter({required this.deleteCurrentAccount});

  Future<void> logout() async {
    try {
      await deleteCurrentAccount.delete();
      navigateTo = '/login';
    } on Error {
      mainError = UIError.unexpected;
    }
  }
}
