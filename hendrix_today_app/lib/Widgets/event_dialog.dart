import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';

import 'package:share_plus/share_plus.dart';

class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0))),
      title: Text(event.title.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold)),
      insetPadding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date: ${event.displayDate()}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          Text(
            'Time: ${event.displayTime()}',
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 20),
          Text(event.desc.toString()),
        ],
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
