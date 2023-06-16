import 'package:flutter/material.dart'
    show DateUtils;

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

  factory Event.fromFirebase(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

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

  /// Checks if `searchQuery` appears in this [Event]'s title or description 
  /// (case-insensitive).
  bool containsString(String searchQuery) =>
    title!.toLowerCase().contains(searchQuery.toLowerCase()) |
    desc!.toLowerCase().contains(searchQuery.toLowerCase());
  
  /// Checks if this [Event]'s date is the same day as `match`. Note that the 
  /// time field of `Event.date` is set to midnight UTC.
  bool matchesDate(DateTime match) => DateUtils.isSameDay(date, match);
}
