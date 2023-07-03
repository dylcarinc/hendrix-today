import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/widgets/event_card.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('The search page can filter events by text',
      (widgetTester) async {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    firestore.collection('events').add({
      "title": "Test Event",
      "desc": "bar baz",
      "type": "Announcement",
      "time": "2pm",
      "date": Timestamp.fromDate(DateTime(2023, 6, 28)),
      "location": "nowhere",
      "beginPosting":
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 2))),
      "endPosting":
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
      "contactName": "Jane Smith",
      "contactEmail": "jsmith@fake.email",
    });
    firestore.collection('events').add({
      "title": "Foo",
      "desc": "Test description.",
      "type": "Event",
      "time": "4pm",
      "date": Timestamp.fromDate(DateTime(2023, 6, 25)),
      "location": "nowhere",
      "beginPosting":
          Timestamp.fromDate(DateTime.now().subtract(const Duration(days: 2))),
      "endPosting":
          Timestamp.fromDate(DateTime.now().add(const Duration(days: 2))),
      "contactName": "Jane Smith",
      "contactEmail": "jsmith@fake.email",
    });

    await widgetTester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(auth, firestore),
        builder: (context, child) => const MaterialApp(
          home: SearchScreen(),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byType(EventCard), findsNWidgets(2),
        reason: 'Both test events should initially appear on the search page');
    expect(find.byKey(const Key('SearchInput')), findsOneWidget,
        reason: 'There should be a search query input field');

    await widgetTester.enterText(find.byKey(const Key('SearchInput')), 'foo');
    await widgetTester.pumpAndSettle();

    expect(find.byType(EventCard), findsOneWidget,
        reason: 'Only the event(s) that match the search query should remain');

    await widgetTester.enterText(find.byKey(const Key('SearchInput')), 'qwert');
    await widgetTester.pumpAndSettle();

    expect(find.byType(EventCard), findsNothing,
        reason: 'No events should appear for a gibberish search query');
  });
}
