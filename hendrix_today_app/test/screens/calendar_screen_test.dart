import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/widgets/event_card.dart';
import 'package:hendrix_today_app/screens/calendar_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('The calendar page initially shows today\'s events',
      (widgetTester) async {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    firestore.collection('events').add({
      "title": "Test Event",
      "desc": "Test description.",
      "type": "Event",
      "time": "2pm",
      "date": Timestamp.fromDate(DateTime.now()),
      "location": "nowhere",
      "beginPosting":
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 2))),
      "endPosting":
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
      "contactName": "Jane Smith",
      "contactEmail": "jsmith@fake.email",
    });
    firestore.collection('events').add({
      "title": "Not Today",
      "desc": "This event happened yesterday.",
      "type": "Event",
      "time": "noon",
      "date":
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 1))),
      "location": null,
      "beginPosting": Timestamp.fromDate(DateTime(2023, 6, 25)),
      "endPosting": Timestamp.fromDate(DateTime(2023, 6, 30)),
      "contactName": "Jane Smith",
      "contactEmail": "jsmith@fake.email",
    });

    await widgetTester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(auth, firestore),
        builder: (context, child) => const MaterialApp(
          home: CalendarScreen(),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byType(EventCard), findsOneWidget,
        reason:
            'Only the event(s) happening today should initially be visible');
    expect(find.text('Not Today'), findsNothing,
        reason: 'Events not happening today should not initally be visible');
  });
}
