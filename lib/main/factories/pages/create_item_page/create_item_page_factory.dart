import 'package:flutter/widgets.dart';
import 'package:personal_health_app/presentation/pages/create_item/create_item_page.dart';
import 'create_item_page_presenter_factory.dart';

Widget makeCreateItemPage() {
  return CreateItemPage(
    presenter: makeGetxCreateItemPresenter(),
  );
}
