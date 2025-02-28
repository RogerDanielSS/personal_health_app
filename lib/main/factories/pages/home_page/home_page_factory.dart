import 'package:flutter/widgets.dart';
import 'package:personal_health_app/presentation/pages/home_page.dart';
import 'home_page_presenter_factory.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: makeGetxHomePresenter(),
  );
}
