import 'package:flutter/material.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';

abstract class LoginPagePresenter implements Listenable {
  Stream<String?> get navigateToStream;
  Stream<UIError?> get mainErrorStream;

  String? validateEmail(String? value);

  String? validatePassword(String? value);

  Future<void> login(String email, String password);
}
