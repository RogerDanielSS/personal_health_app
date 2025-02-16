import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';
import 'package:personal_health_app/presentation/components/card.dart';

class EventsList extends StatelessWidget {
  final List<EventEntity>? events;

  const EventsList({super.key, this.events});

  List<Widget> buildEventsCards(int count) {
    return List.generate(
        count,
        (index) => EventCard(
              event: events![index],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        key: key,
        children: buildEventsCards((events ?? []).length),
      ),
    );
  }
}
