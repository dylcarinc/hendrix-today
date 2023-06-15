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

    final Event event = Event.fromFirebase(testData);

    expect(event.title, testData["title"], reason: "Titles must match");
    expect(event.desc, testData["desc"], reason: "Descriptions must match");
    expect(event.time, testData["time"], reason: "Times must match");
    expect(event.date, testData["date"], reason: "Dates must match");
    expect(event.tags, testData["tags"], reason: "Tags must match");
  });

  test('Event data can be missing', () {
    final Map<String, dynamic> testData = {
      "title": null,
      "desc": null,
      "time": null,
      "date": null,
      "tags": null,
    };

    final Event event = Event.fromFirebase(testData);

    expect(event.title.runtimeType, String, 
      reason: "Title must be a non-nullable String");
    expect(event.desc.runtimeType, String,
      reason: "Description must be a non-nullable String");
    expect(event.time.runtimeType, String,
      reason: "Time must be a non-nullable String");
    expect(event.date.runtimeType, DateTime,
      reason: "Date must be a non-nullable DateTime");
    expect(event.tags.runtimeType, List<String>,
      reason: "Tags must be a non-nullable List<String>");
  });
}