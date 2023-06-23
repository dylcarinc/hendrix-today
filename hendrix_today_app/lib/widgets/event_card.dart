import 'dart:ui';

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
                color: event.eventType.color(),
                width: 5), // this color should come from the style
          ),
        ),
        child: ListTile(
          title: Text(event.title.toString(),
              style: const TextStyle(
                fontVariations: [FontVariation('wght', 600.0)],
              )),
          subtitle: Text(
            event.displayDate(),
            style: const TextStyle(fontStyle: FontStyle.italic),
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
