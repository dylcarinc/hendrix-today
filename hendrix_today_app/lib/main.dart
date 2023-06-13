import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/root_app.dart';
import 'package:hendrix_today_app/objects/app_state.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, _) => const RootApp()),
  ));
}
