import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/user.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';

abstract class MainLayoutPresenter implements Listenable {
  Stream<String?> get navigateToStream;
  Stream<UIError?> get mainErrorStream;
  Stream<bool> get isLoadingStream;
  Stream<UserEntity?> get currentAccountStream;

  Future<void> logout();
  Future<void> loadCurrentAccountData();
}
