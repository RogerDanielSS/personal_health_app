import 'package:personal_health_app/UI/pages/home/home_page_presenter.dart';

import '../../../presentation/presenters/getx_home_page_presenter.dart';
import '../usecases/usecases.dart';

HomePagePresenter makeGetxHomePresenter() {
  return GetxHomePagePresenter(
      loadItems: makeRemoteLoadItems(),
      loadCurrentAccount: makeLocalLoadCurrentAccount());
}
