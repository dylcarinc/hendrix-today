import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';

import 'package:share_plus/share_plus.dart';

class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      title: Container(
        // From https://www.flutterbeads.com/card-border-in-flutter/
        decoration: const BoxDecoration(
          border: Border(
            left: BorderSide(
                color: Color.fromARGB(255, 202, 81, 39),
                width: 5), // this color should come from the style
          ),
        ),
        padding: const EdgeInsetsDirectional.only(start: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(event.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Text(
            'Date: ${event.displayDate()}',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              fontVariations: [FontVariation('wght', 200.0)],
            ),
          ),
          Text(
            'Time: ${event.displayTime()}',
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              fontVariations: [FontVariation('wght', 200.0)],
            ),
          ),
        ]),
      ),
      insetPadding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      content: SingleChildScrollView(
        child: Text(event.desc.toString()),
      ),
      actions: <Widget>[
        IconButton(
            color: Colors.black,
            onPressed: () => Share.share('"${event.title}" -${event.desc}',
                subject: 'Check out this quote!'),
            icon: const Icon(Icons.share_outlined)),
        IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        )
      ],
    );
  }
}
