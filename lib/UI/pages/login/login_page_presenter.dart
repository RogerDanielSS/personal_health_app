import 'package:flutter/material.dart';

abstract class LoginPagePresenter implements Listenable {
  Stream<String?> get navigateToStream;

  Future<void> login(String email, String password);
}
