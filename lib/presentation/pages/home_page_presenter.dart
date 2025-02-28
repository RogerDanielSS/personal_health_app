import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/item.dart';

abstract class HomePagePresenter implements Listenable {
  Stream<List<ItemEntity>> get itemsStream;
  Stream<ItemEntity?> get selectedItemStream;
  // List<ItemEntity> get dayItems;
  Stream<String?> get navigateToStream;
  Stream<bool> get isSessionExpiredStream;

  Future<void> loadItemsData();
  Future<void> logout();

  // void handleTabNavigation(int index);

  // void initValues();

  // List<ItemEntity> getItemsForDay(DateTime day);
}
