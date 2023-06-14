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
      title: Text(event.title.toString()),
      insetPadding: const EdgeInsets.symmetric(
        vertical: 100,
        horizontal: 50
      ),
      content: Column(children: [Text(event.desc.toString())]),
      actions: <Widget>[
        IconButton(
          color: Colors.black,
          onPressed: () => Share.share(
            '"${event.title}" -${event.desc}',
            subject: 'Check out this quote!'
          ),
          icon: const Icon(Icons.share_outlined)
        ),
        IconButton(
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        )
      ],
    );
  }
}
