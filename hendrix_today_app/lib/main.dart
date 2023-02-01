import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:provider/provider.dart';

import 'AppState.dart';
import 'RootApp.dart'; // new

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, child) => const RootApp()),
  ));
}
