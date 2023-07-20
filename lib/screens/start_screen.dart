import 'package:flutter/material.dart';
import 'package:hendrix_today_app/screens/loading_screen.dart';
import 'package:hendrix_today_app/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  late Future<bool> loggedin;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();

    loggedin = _prefs.then((SharedPreferences prefs) {
      return prefs.getBool('loggedin') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: loggedin,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const LoadingScreen();
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const LoginScreen();
              } else {
                if (snapshot.data == true) {
                  return const HomeScreen();
                } else {
                  return const LoginScreen();
                }
              }
          }
        });
  }
}
