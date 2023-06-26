import 'package:flutter/material.dart'
    show DateUtils;

import 'package:hendrix_today_app/objects/event_type.dart';

import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp;
import 'package:intl/intl.dart'
    show DateFormat;

class Event {
  final String title;
  final String desc;
  final EventType eventType;
  final DateTime date;
  final String? time;
  final String? location;
  final String contactName;
  final String contactEmail;
  final DateTime beginPosting;
  final DateTime endPosting;
  final DateTime? applyDeadline;
  final List<String> tags;

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
    required this.tags,
  });

  /// Determines the default sort order for [Event]s.
  int compareByDate(Event other) => date.compareTo(other.date);

  /// Converts Firebase data into an [Event]. The return value will be null if 
  /// the given data is invalid (i.e., has an invalid type or date).
  static Event? fromFirebase(Map<String, dynamic> data) {
    // Convenient caster: https://stackoverflow.com/a/67435226
    T? cast<T>(dynamic x) => (x is T) ? x : null;

    final String? maybeTitle = cast(data["title"]);
    if (maybeTitle == null) return null;
    final String title = maybeTitle;

    final String? maybeDesc = cast(data["desc"]);
    if (maybeDesc == null) return null;
    final String desc = maybeDesc;

    final EventType? maybeEventType = EventType.fromString(data["type"]);
    if (maybeEventType == null) return null;
    final EventType eventType = maybeEventType;
    
    final Timestamp? maybeDate = cast(data["date"]);
    if (maybeDate == null) return null;
    final DateTime date = maybeDate.toDate();

    final String? time = cast(data["time"]);
    final String? location = cast(data["location"]);

    final String? maybeContactName = cast(data["contactName"]);
    if (maybeContactName == null) return null;
    final String contactName = maybeContactName;

    final String? maybeContactEmail = cast(data["contactEmail"]);
    if (maybeContactEmail == null) return null;
    final String contactEmail = maybeContactEmail;
    
    final Timestamp? maybeBeginPosting = cast(data["beginPosting"]);
    if (maybeBeginPosting == null) return null;
    final DateTime beginPosting = maybeBeginPosting.toDate();

    final Timestamp? maybeEndPosting = cast(data["endPosting"]);
    if (maybeEndPosting == null) return null;
    final DateTime endPosting = maybeEndPosting.toDate();

    final DateTime? applyDeadline =
      cast<Timestamp>(data["applyDeadline"])?.toDate();

    final List<String> tags =
      (cast<String>(data["tags"]) ?? "")
      .split(';');

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
      tags: tags,
    );
  }

  /// Formats this [Event]'s date in a human-readable form.
  /// 
  /// Example: `2023-06-14` becomes `Wed, Jun 14, 2023`
  String displayDate() => DateFormat('EEE, MMM d, yyyy').format(date);

  /// Formats this [Event]'s application deadline in a human-readable form.
  /// 
  /// Returns `null` if the deadline is `null`.
  /// 
  /// Example: `2023-06-14` becomes `Wed, Jun 14, 2023`
  String? displayDeadline() => applyDeadline == null
    ? null
    : DateFormat('EEE, MMM d, yyyy').format(applyDeadline!);

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
