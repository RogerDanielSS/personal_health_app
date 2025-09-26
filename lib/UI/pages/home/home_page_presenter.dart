import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/helpers/errors/ui_error.dart';

abstract class HomePagePresenter implements Listenable {
  Stream<String?> get navigateToStream;
  Stream<UIError?> get mainErrorStream;

  Stream<List<ItemEntity>> get itemsStream;
  Stream<ItemEntity?> get selectedItemStream;

  Future<void> handleAddNewItem();
  Future<void> loadItemsData();
}
