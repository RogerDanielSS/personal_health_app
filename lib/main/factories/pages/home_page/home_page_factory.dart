import 'package:flutter/widgets.dart';
import 'package:personal_health_app/presentation/pages/home_page.dart';



Widget makeHomePage() {
  return HomePage(
    presenter: makeGetxHomePresenter(),
  );
}
