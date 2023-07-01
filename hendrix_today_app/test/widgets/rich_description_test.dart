import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/widgets/rich_description.dart';

import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../mocks/url_launcher.mock.dart';

// how to tap a TextSpan within RichText: https://stackoverflow.com/a/60247474
bool findTextAndTap(InlineSpan visitor, String text) {
  if (visitor is TextSpan && visitor.text == text) {
    (visitor.recognizer as TapGestureRecognizer?)?.onTap?.call();
    return false;
  }
  return true;
}

bool tapTextSpan(RichText richText, String text) {
  final isTapped =
      !richText.text.visitChildren((visitor) => findTextAndTap(visitor, text));
  return isTapped;
}

void main() {
  const richText =
      'Lorem ipsum, click <a href=https://pub.dev/>here</a> to find packages.';

  testWidgets('hyperlinks are clickable', (widgetTester) async {
    final List<String> visitedLinks = [];
    final mock = setupMockUrlLauncher((Invocation i) async {
      visitedLinks.add(i.positionalArguments.first);
      return true;
    });
    UrlLauncherPlatform.instance = mock;

    await widgetTester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: RichDescription(text: richText),
          ),
        ),
      ),
    );
    await widgetTester.pumpAndSettle();

    final hyperlinkFinder = find.byWidgetPredicate(
        (widget) => widget is RichText && tapTextSpan(widget, 'here'));

    expect(hyperlinkFinder, findsOneWidget,
        reason: "There should be exactly one instance of the text 'here'");

    await widgetTester.pumpAndSettle(); // wait for the callback to finish

    expect(visitedLinks.length, 1,
        reason: 'Exactly one link should have been clicked');
    expect(visitedLinks.first, 'https://pub.dev/',
        reason: 'The link in the rich description should have been accessed');
  });
}
