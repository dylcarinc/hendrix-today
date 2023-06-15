import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

void main() {

  // Do not alter without thoughtfully updating dependent unit tests
  final List<Map<String, dynamic>> fakeEvents = [
    {
      "title": "Test Title",
      "desc": "lorem ipsum dolor sit amet",
      "time": "12:00-1:00 PM",
      "date": DateTime(2023, 6, 14),
    },
    {
      "title": "Other",
      "date": DateTime(2023, 6, 15),
    },
  ];

  AppState buildMockAppState({
    required bool signedIn,
    required List<Map<String, dynamic>> events
  }) {
    final auth = MockFirebaseAuth(signedIn: signedIn);
    final firestore = FakeFirebaseFirestore();
    for (var event in events) {
      firestore.collection("events").add(event);
    }
    return AppState(auth, firestore);
  }

  test('App state provides a searchable catalog of events', () async {

    final appState = buildMockAppState(signedIn: false, events: fakeEvents);

    expect(appState.searchEvents("").length, fakeEvents.length,
      reason: "Empty search should return all events");
    expect(appState.searchEvents("lorem ipsum").length, 1,
      reason: "Only one event should match ");
  });
}