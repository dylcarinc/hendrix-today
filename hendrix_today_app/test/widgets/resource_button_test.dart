import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/widgets/resource_button.dart';

import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../mocks/url_launcher.mock.dart';

void main() {
  testWidgets('Resource buttons display information', (widgetTester) async {
    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResourceButton(
            titleString: 'Title',
            icon: Icons.abc,
            url: 'invalid url',
            color: Colors.red,
          ),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.text('Title'), findsOneWidget,
        reason: 'The resource title should be visible');
    expect(find.byIcon(Icons.abc), findsOneWidget,
        reason: 'The resource icon should be visible');
  });

  testWidgets('Clicking a resource button opens its url', (widgetTester) async {
    final List<String> linksVisited = [];
    final mock = setupMockUrlLauncher((invocation) async {
      linksVisited.add(invocation.positionalArguments.first);
      return true;
    });
    UrlLauncherPlatform.instance = mock;

    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ResourceButton(
            titleString: 'Title',
            icon: Icons.abc,
            url: 'https://pub.dev',
            color: Colors.red,
          ),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    await widgetTester.tap(find.byType(ResourceButton));
    await widgetTester.pumpAndSettle(); // wait for callback to finish

    expect(linksVisited.length, 1,
        reason: 'Exactly one link should be opened by the resource button');
    expect(linksVisited.first, 'https://pub.dev',
        reason: 'The link from the resource button should have been accessed');
  });
}
