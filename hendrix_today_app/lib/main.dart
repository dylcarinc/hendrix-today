import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:hendrix_today_app/Objects/AppState.dart';
import 'package:hendrix_today_app/Widgets/RootApp.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
    create: (context) => AppState(),
    builder: ((context, _) => const RootApp()),
  ));
}
