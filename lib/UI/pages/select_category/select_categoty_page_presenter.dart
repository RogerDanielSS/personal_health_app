import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

abstract class SelectCategoryPagePresenter implements Listenable {
  Stream<String?> get navigateToStream;
  Stream<List<CategoryEntity>> get categoriesStream;

  Future<void> loadCategoriesData();
  Future<void> handleSelectCategory(CategoryEntity category);
}
