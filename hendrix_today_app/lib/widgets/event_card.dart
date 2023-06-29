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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        // From https://www.flutterbeads.com/card-border-in-flutter/
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
                color: event.eventType.color(context),
                width: 10), // this color should come from the style
          ),
        ),
        child: ListTile(
          title: Text(event.title.toString(),
              style: Theme.of(context).textTheme.headlineMedium),
          subtitle: Text(
            event.displayDate(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => EventDialog(event: event),
            );
          },
        ),
      ),
    );
  }
}
