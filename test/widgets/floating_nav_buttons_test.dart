import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';

void main() {
  Widget createKeyedPage(String key) => Scaffold(
        key: Key(key),
        floatingActionButton: const FloatingNavButtons(),
      );

  testWidgets('Pressing a nav button changes the route', (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        routes: {
          '/home': (context) => createKeyedPage('HomePage'),
          '/calendar': (context) => createKeyedPage('CalendarPage'),
          '/search': (context) => createKeyedPage('SearchPage'),
          '/resources': (context) => createKeyedPage('ResourcesPage'),
        },
        initialRoute: '/home',
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('HomePage')), findsOneWidget);

    await widgetTester.tap(find.byKey(const Key('CalendarButton')));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('CalendarPage')), findsOneWidget,
        reason:
            'The calendar button should have navigated to the calendar page');

    await widgetTester.tap(find.byKey(const Key('ResourcesButton')));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('ResourcesPage')), findsOneWidget,
        reason:
            'The resources button should have navigated to the resources page');
  });
}
