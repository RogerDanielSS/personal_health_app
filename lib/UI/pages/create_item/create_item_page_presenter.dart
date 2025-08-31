import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

abstract class CreateItemPagePresenter implements Listenable {
  Stream<CategoryEntity?> get currentCategoryStream;

  Future<void> loadCurrentCategoryData();
  Future<void> createItemData(int categoryId, Map<String, String> fields);
}
