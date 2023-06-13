import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/screens/home_screen.dart';
import 'package:hendrix_today_app/screens/calendar_screen.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';
import 'package:hendrix_today_app/widgets/event_calendar.dart';

//worked before firebase implementation

void main() {
  testWidgets('Home Screen has cards', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: MyHomeScreen())));
    await tester.pumpAndSettle();

    expect(find.byType(Card), findsAtLeastNWidgets(1));
  });

  testWidgets('Calendar Screen is populated', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: CalendarScreen())));
    await tester.pumpAndSettle();

    expect(find.byType(EventCalendar), findsOneWidget);
  });

  testWidgets('Search Screen exists and has searchBar', (tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: SearchScreen())));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsOneWidget);
  });
}
