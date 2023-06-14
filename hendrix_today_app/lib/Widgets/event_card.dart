import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_dialog.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    
    // This block may be useful when we start working on event tags
    //
    // List<Widget> tagButtonList = [];
    // if (event.tags != null && event.tags!.isNotEmpty) {
    //   for (var i = 0; i < event.tags!.length; i++) {
    //     tagButtonList.add(
    //       TagButton(
    //         onPressed: (){}, // apply tag filter
    //         btnText: event.tags!.elementAt(i)
    //       ));
    //   }
    // }

    return Card(
      child: ListTile(
        title: Text(event.title.toString()),
        subtitle: Text(event.displayDate()),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => EventDialog(event: event),
          );
        },
      ),
    );
  }
}
