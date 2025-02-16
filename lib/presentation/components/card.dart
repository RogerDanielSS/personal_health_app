import 'package:flutter/material.dart';
import 'package:personal_health_app/domain/entities/entities.dart';

class EventCard extends StatelessWidget {
  final EventEntity? event;

  const EventCard({
    super.key,
    this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: key,
      color: Colors.blue[100],
      child: Padding(
          padding: EdgeInsets.all(8),
          child: SizedBox(
            width: double.infinity,
            height: 150,
            child: Column(
              children: [
                Text(
                  event!.title,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                Text(
                  event!.column1,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.w300),
                )
              ],
            ),
          )),
    );
  }
}
