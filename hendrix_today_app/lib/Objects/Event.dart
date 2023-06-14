import 'package:intl/intl.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final DateTime? date;
  List<String>? tags;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
    this.tags,
  });

  /// Formats this [Event]'s date in a human-readable form.
  /// Null dates return `'None available'`.
  /// 
  /// Example: `2023-06-14` becomes `Wed, Jun 14, 2023`
  String displayDate() {
    final DateFormat formatter = DateFormat('EEE, MMM d, yyyy');
    if (date != null) {
      return formatter.format(date!);
    } else {
      return 'None available';
    }
  }

  /// Returns this [Event]'s time, or `'None available'` if it is null.
  String displayTime() => time ?? 'None available';
}
