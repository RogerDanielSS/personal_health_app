import 'package:get/get.dart';

import 'package:personal_health_app/UI/pages/login/login_page_presenter.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';
import 'package:personal_health_app/presentation/mixins/validation_manager.dart';

import '../../../domain/usecases/usecases.dart';
import '../mixins/mixins.dart';

class GetxLoginPagePresenter extends GetxController
    with
        SessionManager,
        NavigationManager,
        ValidationManager,
        UIErrorManager,
        LoadingManager
    implements LoginPagePresenter {
  final Authentication authentication;
  final SaveCurrentAccount saveCurrentAccount;

  GetxLoginPagePresenter({
    required this.authentication,
    required this.saveCurrentAccount,
  });

  @override
  Future<void> login(String email, String password) async {
    try {
      final account = await authentication
          .auth(AuthenticationParams(email: email, password: password));

      await saveCurrentAccount.save(account);

      navigateTo = '/items';
    } catch (e) {
      mainError = UIError.unexpected;
    }
  }
}
