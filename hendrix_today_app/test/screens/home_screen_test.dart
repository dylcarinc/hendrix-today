import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:provider/provider.dart';

void main() {
  Widget appStateProvider(Widget Function(BuildContext, Widget?) builder) {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();
    firestore.collection('events').add({
      "title": "Test Event",
      "desc": "Test description.",
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
    return ChangeNotifierProvider(
      create: (context) => AppState(auth, firestore),
      builder: builder,
    );
  }

  testWidgets('The home page displays current events', (widgetTester) async {
    await widgetTester.pumpWidget(appStateProvider(
        (context, _) => const MaterialApp(home: HomeScreen())));
    await widgetTester.pumpAndSettle();

    expect(find.text('Test Event'), findsOneWidget,
        reason:
            'The home page should display an event during its posting range');
  });

  testWidgets('The home page can filter events by type', (widgetTester) async {
    await widgetTester.pumpWidget(appStateProvider(
        (context, _) => const MaterialApp(home: HomeScreen())));
    await widgetTester.pumpAndSettle();

    expect(find.text('Test Event'), findsOneWidget,
        reason: 'The home page should display all events initially');
    expect(find.byKey(const Key('EventTypeFilterDropdown')), findsOneWidget,
        reason: 'There should be a filter dropdown on the home page');

    await widgetTester.tap(find.byKey(const Key('EventTypeFilterDropdown')));
    await widgetTester.pumpAndSettle();

    expect(find.text('Meetings'), findsOneWidget,
        reason: 'There should be a \'Meetings\' filter option');

    await widgetTester.tap(find.text('Meetings'));
    await widgetTester.pumpAndSettle();

    expect(find.text('Test Event'), findsNothing,
        reason: 'The filter should remove events with undesired types');
  });
}
