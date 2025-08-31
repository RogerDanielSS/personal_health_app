import 'package:flutter/material.dart';

abstract class LoginPagePresenter implements Listenable {
  Stream<String?> get navigateToStream;

  String? validateEmail(String? value);

  String? validatePassword(String? value);

  Future<void> login(String email, String password);
}
