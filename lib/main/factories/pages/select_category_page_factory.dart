import 'package:flutter/widgets.dart';
import 'package:personal_health_app/UI/pages/select_category/select_category.dart';
import 'package:personal_health_app/main/factories/presenters/select_category_page_presenter_factory.dart';

Widget makeSelectCategoryPage() {
  return SelectCategoryPage(
    presenter: makeGetxSelectCategoryPresenter(),
  );
}
