import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

abstract class HomePagePresenter implements Listenable {
  Stream<List<ItemEntity>> get itemsStream;
  Stream<ItemEntity?> get selectedItemStream;
  Stream<List<CategoryEntity>> get categoriesStream;
  Stream<String?> get navigateToStream;
  Stream<bool> get isSessionExpiredStream;

  Future<void> loadItemsData();
  Future<void> loadCategoriesData();
  Future<void> saveCategory(CategoryEntity category);
  Future<void> logout();
}
