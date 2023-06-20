import 'package:flutter/material.dart'
    show DateUtils;

import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp;
import 'package:intl/intl.dart'
    show DateFormat;

enum EventType {
  event, meeting, announcement, lostAndFound;

  static EventType? fromString(String? s) {
    const map = <String, EventType>{
      "event": event, "events": event,
      "meeting": meeting, "meetings": meeting,
      "announcement": announcement, "announcements": announcement,
      "lost & found": lostAndFound, "lost and found": lostAndFound,
    };
    return map[s?.trim().toLowerCase()];
  }
}

class Event {
  final String title;
  final String desc;
  final EventType eventType;
  final DateTime date;
  final String time;
  final String location;
  final String contactName;
  final String contactEmail;
  final DateTime beginPosting;
  final DateTime endPosting;
  final DateTime? applyDeadline;

  /// Default [Event] constructor. When constructing events from Firebase data, 
  /// please consider using `Event.fromFirebase(Map<String, dynamic> data)`.
  Event({
    required this.title,
    required this.desc,
    required this.eventType,
    required this.date,
    required this.time,
    required this.location,
    required this.contactName,
    required this.contactEmail,
    required this.beginPosting,
    required this.endPosting,
    required this.applyDeadline,
  });

  /// Converts Firebase data into an [Event]. The return value will be null if 
  /// the given data is invalid (i.e., has an invalid type or date).
  static Event? fromFirebase(Map<String, dynamic> data) {
    // Convenient caster: https://stackoverflow.com/a/67435226
    T? cast<T>(dynamic x) => (x is T) ? x : null;

    final String title = cast(data["title"]) ?? "Untitled Event";
    final String desc = cast(data["desc"]) ?? "No description given.";

    final EventType? maybeEventType = EventType.fromString(data["type"]);
    if (maybeEventType == null) { return null; }
    final EventType eventType = maybeEventType;
    
    final Timestamp? maybeDate = cast(data["date"]);
    if (maybeDate == null) { return null; }
    final DateTime date = maybeDate.toDate();

    final String time = cast(data["time"]) ?? "No time given";
    final String location = cast(data["location"]) ?? "No location given";

    final String contactName =
      cast(data["contactName"]) ?? "No contact name given";
    final String contactEmail =
      cast(data["contactEmail"]) ?? "No contact email given";
    
    final Timestamp? maybeBeginPosting = cast(data["beginPosting"]);
    if (maybeBeginPosting == null) { return null; }
    final DateTime beginPosting = maybeBeginPosting.toDate();

    final Timestamp? maybeEndPosting = cast(data["endPosting"]);
    if (maybeEndPosting == null) { return null; }
    final DateTime endPosting = maybeEndPosting.toDate();

    final DateTime? applyDeadline =
      cast<Timestamp>(data["applyDeadline"])?.toDate();

    return Event(
      title: title,
      desc: desc,
      eventType: eventType,
      date: date,
      time: time,
      location: location,
      contactName: contactName,
      contactEmail: contactEmail,
      beginPosting: beginPosting,
      endPosting: endPosting,
      applyDeadline: applyDeadline,
    );
  }

  /// Formats this [Event]'s date in a human-readable form.
  /// Null dates return `'None available'`.
  /// 
  /// Example: `2023-06-14` becomes `Wed, Jun 14, 2023`
  String displayDate() => DateFormat('EEE, MMM d, yyyy').format(date);

  /// Checks if `searchQuery` appears in this [Event]'s title or description 
  /// (case-insensitive).
  bool containsString(String searchQuery) =>
    title.toLowerCase().contains(searchQuery.toLowerCase()) |
    desc.toLowerCase().contains(searchQuery.toLowerCase());
  
  /// Checks if this [Event]'s date is the same day as `match`. Note that the 
  /// time field of `Event.date` is set to midnight UTC.
  bool matchesDate(DateTime match) => DateUtils.isSameDay(date, match);

  /// Checks if the given [DateTime] falls in this [Event]'s posting range.
  /// Includes both range end points.
  bool inPostingRange(DateTime day) =>
    DateUtils.isSameDay(day, beginPosting) ||
    DateUtils.isSameDay(day, endPosting) ||
    (day.isAfter(beginPosting) && day.isBefore(endPosting));
}
