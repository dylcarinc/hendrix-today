import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/rich_description.dart';

import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

/// A detailed display of an [HDXEvent] built on the [AlertDialog] widget.
///
/// This dialog holds all [HDXEvent] information accessible to the user, so its
/// layout must be thoughtfully planned. This widget conforms to the Hendrix
/// College style guide.
class EventDialog extends StatelessWidget {
  const EventDialog({super.key, required this.event});
  final HDXEvent event;

  /// Attempts to begin a draft email to the [HDXEvent.contactEmail].
  ///
  /// Fails if the [event]'s contact email cannot be parsed into a [Uri].
  void _tryEmailContact() async {
    final subject = 'Hendrix Today - response to "${event.title}"';
    final mailto = 'mailto:${event.contactEmail}?subject=$subject';
    final uri = Uri.tryParse(mailto);
    if (uri == null) return;
    // skip the `canLaunchUrl(uri)` check because mailto: links fail
    launchUrl(uri);
  }

  void _titleLimiter(String eventTitle) async {
    if (eventTitle.length > 60) {
      eventTitle = "${eventTitle.substring(0, 60)}...";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 50),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.0))),
      titlePadding: const EdgeInsets.fromLTRB(0, 24, 18, 0),
      title: Stack(
        children: [
          Container(
            // From https://www.flutterbeads.com/card-border-in-flutter/
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                    color: event.eventType.color(context), width: 16),
              ),
            ),
            padding: const EdgeInsetsDirectional.only(start: 8.0, end: 20.0),
            // minimum height to contain all 3 side buttons
            constraints: const BoxConstraints(minHeight: 160.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title.toString(),
                    style: Theme.of(context).textTheme.headlineLarge,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 5),
                Text(
                  event.eventType.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: event.eventType.color(context)),
                ),
                const SizedBox(height: 5),
                Text(
                  "∙ ${event.displayDate()}",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                if (event.time != null)
                  Text(
                    "∙ ${event.time!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                if (event.location != null)
                  Text(
                    "∙ ${event.location!}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
              ],
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
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => Share.share(
                      '"${event.title}" -${event.desc}',
                      subject: 'Check out this event!'),
                  icon: const Icon(Icons.share),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.only(right: 2.0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () => _tryEmailContact(),
                  icon: const Icon(Icons.mail_outlined),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: const EdgeInsets.only(right: 2.0),
                  color: Theme.of(context).colorScheme.primary,
                  onPressed: () {
                    final Event calevent = Event(
                        title: event.time == null
                            ? event.title
                            : "${event.title}: ${event.time}",
                        description: event.desc,
                        location: event.location,
                        startDate: event.date,
                        endDate: event.date,
                        allDay: event.time == null);
                    Add2Calendar.addEvent2Cal(calevent);
                  },
                  icon: const Icon(Icons.edit_calendar),
                ),
              ],
            ),
          ),
        ],
      ),
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
          Flexible(
            child: SingleChildScrollView(
              child: RichDescription(text: event.desc),
            ),
          ),
        ],
      ),
    );
  }
}
