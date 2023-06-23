import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/rich_description.dart';

import 'package:share_plus/share_plus.dart';

class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(0, 24, 18, 0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      title: Stack(children: [
        Container(
          // From https://www.flutterbeads.com/card-border-in-flutter/
          decoration: const BoxDecoration(
            border: Border(
              left: BorderSide(
                  color: Color.fromARGB(255, 202, 81, 39),
                  width: 16), // this color should come from the style
            ),
          ),
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(event.title.toString(),
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              event.displayDate(),
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontVariations: [FontVariation('wght', 200.0)],
              ),
            ),
            Text(
              event.time,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontVariations: [FontVariation('wght', 200.0)],
              ),
            ),
          ]),
        ),
        Positioned(
          top: -15.0,
          right: -15.0,
          child: Column(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
                  color: const Color.fromARGB(255, 202, 81, 39),
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context)),
              IconButton(
                  color: const Color.fromARGB(255, 202, 81, 39),
                  onPressed: () => Share.share(
                      '"${event.title}" -${event.desc}',
                      subject: 'Check out this event!'),
                  icon: const Icon(Icons.share_outlined)),
            ],
          ),
        ),
      ]),
      insetPadding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      content: SingleChildScrollView(
        // child: Text(event.desc.toString()),
        child: RichDescription(text: event.desc),
      ),
    );
  }
}
