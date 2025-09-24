import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/domain/entities/local_file.dart';

abstract class CreateItemPagePresenter implements Listenable {
  Stream<CategoryEntity?> get currentCategoryStream;
  Stream<List<LocalFileEntity>?> get selectedImagesStream;

  Future<void> loadCurrentCategoryData();
  Future<void> createItemData(int categoryId, Map<String, String> fields);
  Future<void> selectImageFiles();
}
