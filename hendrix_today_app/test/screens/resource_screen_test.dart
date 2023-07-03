import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/screens/resource_screen.dart';

void main() {
  testWidgets('The home page displays current events', (widgetTester) async {
    await widgetTester.pumpWidget(const MaterialApp(home: ResourcesScreen()));
    await widgetTester.pumpAndSettle();

    expect(find.byKey(const Key('SubmitEventButton')), findsOneWidget,
        reason: 'There should be a button to submit events');
    expect(find.byKey(const Key('CafMenuButton')), findsOneWidget,
        reason: 'There should be a button that links to the caf menu webpage');
    expect(find.byKey(const Key('PublicSafetyButton')), findsOneWidget,
        reason: 'There should be a button to call Public Safety');
    expect(find.byKey(const Key('MapButton')), findsOneWidget,
        reason: 'There should be a button that links to the campus map');
  });
}
