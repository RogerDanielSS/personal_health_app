import 'package:flutter/widgets.dart';
import 'package:personal_health_app/main/factories/usecases/load_current_account_factory.dart';
import 'package:personal_health_app/UI/pages/home/home_page.dart';
import '../presenters/home_page_presenter_factory.dart';

Widget makeHomePage() {
  return HomePage(
    presenter: makeGetxHomePresenter(),
    loadCurrentAccount: makeLocalLoadCurrentAccount(),
  );
}
