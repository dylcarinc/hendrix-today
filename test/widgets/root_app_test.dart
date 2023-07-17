import 'package:flutter_test/flutter_test.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/widgets/root_app.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('The root app starts on the home screen', (widgetTester) async {
    final auth = MockFirebaseAuth();
    final firestore = FakeFirebaseFirestore();

    await widgetTester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => AppState(auth, firestore),
        builder: (context, _) => const RootApp(),
      ),
    );
    await widgetTester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget,
        reason: 'The app should start at the home screen');
  });
}
