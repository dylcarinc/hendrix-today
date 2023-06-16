import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {

  test('AppState maintains an updated list of events', () async {
    final auth = MockFirebaseAuth(signedIn: false);
    final firestore = FakeFirebaseFirestore();
    final fakeEvents = [
      {
        "title": "Test event",
        "desc": "Test description",
        "time": "5pm",
        "date": DateTime(2023, 6, 15),
      },
      {
        "title": "Other",
        "desc": "foo",
        "time": "12pm",
        "date": DateTime(2023, 6, 16),
      },
    ];
    for (var event in fakeEvents) {
      await firestore.collection("events").add(event);
    }
    final appState = AppState(auth, firestore);

    expect(appState.events.length, 2,
      reason: "The mock Firestore started with 2 events.");

    await firestore.collection("events").add({
      "title": "Three",
      "desc": "bar",
      "time": "10am",
      "date": DateTime(2023, 6, 17),
    });

    expect(appState.events.length, 3,
      reason: "A third event was added to the mock Firestore.");
  });
}