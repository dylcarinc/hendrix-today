import 'package:flutter/material.dart';

enum EventType {
  event,
  announcement,
  meeting;

  @override
  String toString() {
    switch (this) {
      case event:
        return "Event";
      case announcement:
        return "Announcement";
      case meeting:
        return "Meeting";
    }
  }

  /// Reads an [EventType] from a string; used to interpret event type data
  /// stored in a Firestore database. The interpretation is not case-sensitive
  /// and allows for plural strings (e.g., both "event" and "events").
  static EventType? fromString(String? str) {
    switch (str?.trim().toLowerCase()) {
      case "event":
      case "events":
        return event;
      case "announcement":
      case "announcements":
        return announcement;
      case "meeting":
      case "meetings":
        return meeting;
      default:
        return null;
    }
  }

  /// Checks if this [EventType] matches the given [EventTypeFilter].
  /// Attempting to match a `null` filter will return `false`.
  bool matchesFilter(EventTypeFilter? filter) {
    switch (filter) {
      case EventTypeFilter.events:
        return this == event;
      case EventTypeFilter.announcements:
        return this == announcement;
      case EventTypeFilter.meetings:
        return this == meeting;
      case EventTypeFilter.all:
        return true;
      case null:
        return false;
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case event: return Theme.of(context).colorScheme.primary;
      case announcement: return Theme.of(context).colorScheme.secondary;
      case meeting: return Theme.of(context).colorScheme.tertiary;
    }
  }
}

enum EventTypeFilter {
  all,
  events,
  announcements,
  meetings;

  @override
  String toString() {
    switch (this) {
      case events:
        return "Events";
      case announcements:
        return "Announcements";
      case meetings:
        return "Meetings";
      case all:
        return "All";
    }
  }

  /// Reads an [EventTypeFilter] from a string; used to update the current
  /// filter using a [DropdownButton] widget.
  static EventTypeFilter? fromString(String? str) {
    switch (str?.trim().toLowerCase()) {
      case "events":
        return events;
      case "announcements":
        return announcements;
      case "meetings":
        return meetings;
      case "all":
        return all;
      default:
        return null;
    }
  }
}
