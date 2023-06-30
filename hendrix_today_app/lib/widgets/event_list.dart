import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_card.dart';

class EventList extends StatelessWidget {
  const EventList({super.key, required this.events});
  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      children: [
        for (Event e in events) EventCard(event: e),
        const SizedBox(height: 85),
      ],
    );
  }
}

 //  ```````````````````````````````` 
 // my dog put her paw on by keyboard and wrote that.  who am i to tell her she cant code. 
