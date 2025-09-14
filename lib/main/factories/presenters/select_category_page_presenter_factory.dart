import 'package:personal_health_app/UI/pages/select_category/select_categoty_page_presenter.dart';
import 'package:personal_health_app/main/factories/usecases/load_categories_factory.dart';
import 'package:personal_health_app/presentation/presenters/getx_select_category_page_presenter.dart';

import '../usecases/usecases.dart';

SelectCategoryPagePresenter makeGetxSelectCategoryPresenter() {
  return GetxSelectCategoryPagePresenter(
      saveCurrentCategory: makeLocalSaveCurrentCategory(),
      loadCategories: makeRemoteLoadCategories(),
      loadCurrentAccount: makeLocalLoadCurrentAccount());
}
