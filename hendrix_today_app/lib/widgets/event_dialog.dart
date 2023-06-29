import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/rich_description.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final Event event;

  /// Attempts to begin a draft email to the [Event] contact.
  void _tryEmailContact() async {
    final subject = "Hendrix Today - response to \"${event.title}\"";
    final mailto = "mailto:${event.contactEmail}?subject=$subject";
    final uri = Uri.tryParse(mailto);
    if (uri == null) { return; }
    // skip the `canLaunchUrl(uri)` check because mailto: links fail
    launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: const EdgeInsets.fromLTRB(0, 24, 18, 0),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      title: Stack(children: [
        Container(
          // From https://www.flutterbeads.com/card-border-in-flutter/
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                  color: event.eventType.color(context),
                  width: 16),
            ),
          ),
          padding: const EdgeInsetsDirectional.only(start: 8.0, end: 20.0),
          // minimum height to contain all 3 side buttons
          constraints: const BoxConstraints(minHeight: 120.0),
          child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.title.toString(),
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 5),
                  Text(
                    event.eventType.toString(),
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: event.eventType.color(context),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "∙ ${event.displayDate()}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (event.time != null) Text(
                    "∙ ${event.time!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (event.location != null) Text(
                    "∙ ${event.location!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                ]
              ),
        ),
        Positioned(
          top: -15.0,
          right: -15.0,
          child: Column(
            children: [
              IconButton(
                  padding: const EdgeInsets.all(0),
                  color: Theme.of(context).colorScheme.primary,
                  icon: const Icon(
                    Icons.close,
                  ),
                  onPressed: () => Navigator.pop(context)),
              IconButton(
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => Share.share(
                      '"${event.title}" -${event.desc}',
                      subject: 'Check out this event!'),
                  icon: const Icon(Icons.share_outlined)),
              IconButton(
                padding: const EdgeInsets.only(right: 2.0),
                color: Theme.of(context).colorScheme.primary,
                onPressed: () => _tryEmailContact(),
                icon: const Icon(Icons.mail_outlined),
              )
            ],
          ),
        ),
      ]),
      insetPadding: const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (event.applyDeadline != null) ...[
            Text(
              "This ${event.eventType.toString()} has a deadline: ",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            Text(
              event.displayDeadline()!,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 5),
          ],
          SingleChildScrollView(
            child: RichDescription(text: event.desc),
          ),
        ],
      ),
    );
  }
}
