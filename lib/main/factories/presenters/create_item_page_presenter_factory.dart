import 'package:personal_health_app/main/factories/usecases/create_item_factory.dart';
import 'package:personal_health_app/presentation/presenters/getx_create_item_page_presenter.dart';

import '../usecases/usecases.dart';

GetxCreateItemPagePresenter makeGetxCreateItemPresenter() {
  return GetxCreateItemPagePresenter(
    loadCurrentCategory: makeLocalLoadCurrentCategory(),
    createItem: makeRemoteCreateItem()
  );
}
