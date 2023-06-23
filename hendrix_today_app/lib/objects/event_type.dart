import 'package:flutter/material.dart'
    show Color;

enum EventType {
  event, announcement, meeting;

  @override
  String toString() {
    switch (this) {
      case event: return "Event";
      case announcement: return "Announcement";
      case meeting: return "Meeting";
    }
  }

  /// Reads an [EventType] from a string; used to interpret event type data 
  /// stored in a Firestore database. The interpretation is not case-sensitive 
  /// and allows for plural strings (e.g., both "event" and "events").
  static EventType? fromString(String? str) {
    switch (str?.trim().toLowerCase()) {
      case "event":
      case "events": return event;
      case "announcement":
      case "announcements": return announcement;
      case "meeting":
      case "meetings": return meeting;
      default: return null;
    }
  }

  /// Checks if this [EventType] matches the given [EventTypeFilter]. 
  /// Attempting to match a `null` filter will return `false`.
  bool matchesFilter(EventTypeFilter? filter) {
    switch (filter) {
      case EventTypeFilter.events: return this == event;
      case EventTypeFilter.announcements: return this == announcement;
      case EventTypeFilter.meetings: return this == meeting;
      case EventTypeFilter.all: return true;
      case null: return false;
    }
  }

  Color color() {
    switch (this) {
      case event: return const Color.fromARGB(255, 202, 81, 39);
      case announcement: return const Color.fromARGB(255, 0, 0, 0);
      case meeting: return const Color.fromARGB(255, 128, 128, 128);
    }
  }
}

enum EventTypeFilter {
  events, announcements, meetings, all;

  @override
  String toString() {
    switch (this) {
      case events: return "Events";
      case announcements: return "Announcements";
      case meetings: return "Meetings";
      case all: return "All";
    }
  }

  /// Reads an [EventTypeFilter] from a string; used to update the current 
  /// filter using a [DropdownButton] widget.
  static EventTypeFilter? fromString(String? str) {
    switch (str?.trim().toLowerCase()) {
      case "events": return events;
      case "announcements": return announcements;
      case "meetings": return meetings;
      case "all": return all;
      default: return null;
    }
  }
}
