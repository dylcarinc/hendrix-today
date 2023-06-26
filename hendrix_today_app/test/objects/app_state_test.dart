import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event_type.dart';

import 'package:cloud_firestore/cloud_firestore.dart'
    show Timestamp;
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {

  test('AppState maintains an updated list of events', () async {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    final fakeEvents = [
      {
        "title": "Test event",
        "desc": "Test description",
        "type": "Event",
        "time": "5pm",
        "date": Timestamp.fromDate(DateTime(2023, 6, 15)),
        "location": "nowhere",
        "beginPosting": Timestamp.fromDate(DateTime(2023, 6, 7)),
        "endPosting": Timestamp.fromDate(DateTime(2023, 6, 14)),
        "contactName": "Jane Smith",
        "contactEmail": "jsmith@fake.email",
      },
      {
        "title": "Other",
        "desc": "foo",
        "type": "Event",
        "time": "12pm",
        "date": Timestamp.fromDate(DateTime(2023, 6, 16)),
        "location": "nowhere",
        "beginPosting": Timestamp.fromDate(DateTime(2023, 6, 7)),
        "endPosting": Timestamp.fromDate(DateTime(2023, 6, 14)),
        "contactName": "Jane Smith",
        "contactEmail": "jsmith@fake.email",
      },
    ];
    final appState = AppState(auth, firestore);
    
    for (var event in fakeEvents) {
      await firestore.collection("events").add(event);
    }

    expect(appState.events.length, 2,
      reason: "The mock Firestore started with 2 events.");

    await firestore.collection("events").add({
      "title": "Three",
      "desc": "bar",
      "type": "Event",
      "time": "10am",
      "date": Timestamp.fromDate(DateTime(2023, 6, 17)),
      "location": "nowhere",
      "beginPosting": Timestamp.fromDate(DateTime(2023, 6, 7)),
      "endPosting": Timestamp.fromDate(DateTime(2023, 6, 14)),
      "contactName": "Jane Smith",
      "contactEmail": "jsmith@fake.email",
    });

    expect(appState.events.length, 3,
      reason: "A third event was added to the mock Firestore.");
  });

  test('The default event type filter is "All"', () {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    final appState = AppState(auth, firestore);

    expect(appState.eventTypeFilter, EventTypeFilter.all);
  });

  test('The event type filter can be updated via a `String?`', () {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    final appState = AppState(auth, firestore);

    appState.updateEventTypeFilter("meetings");

    expect(appState.eventTypeFilter, EventTypeFilter.meetings,
      reason: "A valid event type change should update the filter");
    
    appState.updateEventTypeFilter("asdfalwkjfbnaervf");

    expect(appState.eventTypeFilter, EventTypeFilter.meetings,
      reason: "An invalid event type change should not update the filter");

    appState.updateEventTypeFilter(null);

    expect(appState.eventTypeFilter, EventTypeFilter.meetings,
      reason: "An invalid event type change should not update the filter");
  });
}
