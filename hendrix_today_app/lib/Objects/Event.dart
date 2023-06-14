import 'package:intl/intl.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final DateTime? date; // change this to date
  List<String>? tags;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
    this.tags,
  });

  /// Formats this [Event]'s date in a human-readable form.
  /// 
  /// Example: `2023-06-14` becomes `Wed, Jun 14, 2023`
  String dateToString() {
    final DateFormat formatter = DateFormat('EEE, MMM d, yyyy');
    final String tmpdate = formatter.format(date ?? DateTime.now());
    return tmpdate;
  }
}
