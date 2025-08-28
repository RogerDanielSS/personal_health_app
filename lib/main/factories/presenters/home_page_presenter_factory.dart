import 'package:personal_health_app/main/factories/usecases/load_categories_factory.dart';
import 'package:personal_health_app/UI/pages/home/home_page_presenter.dart';

import '../../../presentation/presenters/getx_home_page_presenter.dart';
import '../usecases/usecases.dart';

HomePagePresenter makeGetxHomePresenter() {
  return GetxHomePagePresenter(
      saveCurrentCategory: makeLocalSaveCurrentCategory(),
      loadItems: makeRemoteLoadItems(),
      loadCategories: makeRemoteLoadCategories(),
      deleteCurrentAccount: makeLocalDeleteCurrentAccount(),
      loadCurrentAccount: makeLocalLoadCurrentAccount());
}
