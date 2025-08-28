import 'package:flutter/widgets.dart';
import 'package:personal_health_app/UI/pages/pages.dart';
import 'package:personal_health_app/main/factories/pages/login_page/login_page_presenter_factory.dart';

Widget makeLoginPage() {
  return LoginPage(
    presenter: makeGetxLoginPagePresenter(),
  );
}
