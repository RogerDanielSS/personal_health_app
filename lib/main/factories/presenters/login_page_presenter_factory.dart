
import 'package:personal_health_app/presentation/presenters/getx_login_page_presenter.dart';

import '../../../UI/pages/pages.dart';
import '../usecases/usecases.dart';

LoginPagePresenter makeGetxLoginPagePresenter() {
  return GetxLoginPagePresenter(
      authentication: makeRemoteAuthentication(),
      saveCurrentAccount: makeLocalSaveCurrentAccount());
}
