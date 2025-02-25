

import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/event.dart';

abstract class HomePagePresenter implements Listenable {

  Stream<List<EventEntity>> get eventsStream;
  Stream<EventEntity?> get selectedEventStream;
  // List<EventEntity> get dayEvents;
  Stream<String?> get navigateToStream;
  Stream<bool> get isSessionExpiredStream;

  Future<void> loadEventsData();
  Future<void> logout();

  // void handleTabNavigation(int index);

  // void initValues();

  // List<EventEntity> getEventsForDay(DateTime day);
}
