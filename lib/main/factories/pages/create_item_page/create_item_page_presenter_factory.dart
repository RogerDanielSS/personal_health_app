import 'package:personal_health_app/presentation/presenters/getx_create_item_page_presenter.dart';

import '../../usecases/usecases.dart';

GetxCreateItemPagePresenter makeGetxCreateItemPresenter() {
  return GetxCreateItemPagePresenter(
    loadCurrentCategory: makeLocalLoadCurrentCategory(),
  );
}
