import 'package:personal_health_app/UI/components/main_layout/main_layout_presenter.dart';
import 'package:personal_health_app/presentation/presenters/getx_main_layout_presenter.dart';

import '../usecases/delete_current_account_factory.dart';

MainLayoutPresenter makeGetxMainLayoutPresenter() {
  return GetxMainLayoutPresenter(
    deleteCurrentAccount: makeLocalDeleteCurrentAccount(),
  );
}
