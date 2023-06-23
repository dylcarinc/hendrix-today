import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/event.dart';

void main() {
  test('Events can hold event data', () {
    final Map<String, dynamic> testData = {
      "title": "Some Test Data",
      "desc": "This will never see the light of day",
      "time": "3:00 PM",
      "date": DateTime(2023, 6, 14),
      "tags": ["test", "Meetings"],
    };

    final event = Event.fromFirebase(testData)!;

    expect(event.title, testData["title"], reason: "Titles must match");
    expect(event.desc, testData["desc"], reason: "Descriptions must match");
    expect(event.time, testData["time"], reason: "Times must match");
    expect(event.date, testData["date"], reason: "Dates must match");
    expect(event.tags, testData["tags"], reason: "Tags must match");
  });

  test('Event date should display as a formatted String', () {
    final Map<String, dynamic> withDate = {
      "title": "foo",
      "desc": "bar",
      "time": "5pm",
      "date": DateTime(2023, 6, 14),
    };
    final Map<String, dynamic> withoutDate = {
      "title": "foo",
      "desc": "bar",
      "time": "5pm",
      "date": null,
    };

    final eventWithDate = Event.fromFirebase(withDate)!;
    final eventWithoutDate = Event.fromFirebase(withoutDate)!;

    expect(eventWithDate.displayDate(), "Wed, Jun 14, 2023");
    expect(eventWithoutDate.displayDate(), "None available");
  });

  test('Event should appropriately respond to search queries', () {
    final Map<String, dynamic> testData = {
      "title": "Some Test Data",
      "desc": "This will never see the light of day",
      "time": "3:00 PM",
      "date": DateTime(2023, 6, 14),
    };

    final event = Event.fromFirebase(testData)!;

    expect(event.containsString("light"), true);
    expect(event.containsString("Some"), true);
    expect(event.containsString("fworbel"), false);
  });

  test('Event should appropriately match with DateTimes by day', () {
    final Map<String, dynamic> testData = {
      "title": "Some Test Data",
      "desc": "This will never see the light of day",
      "time": "3:00 PM",
      "date": DateTime(2023, 6, 14),
    };

    final event = Event.fromFirebase(testData)!;

    expect(event.matchesDate(DateTime(2023, 6, 14)), true);
    expect(event.matchesDate(DateTime(2022, 6, 14)), false);
    expect(event.matchesDate(DateTime(2023, 7, 14)), false);
    expect(event.matchesDate(DateTime(2023, 6, 4)), false);
  });
}