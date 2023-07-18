import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/theme_data.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';
import 'package:hendrix_today_app/screens/calendar_screen.dart';
import 'package:hendrix_today_app/screens/login_screen.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';
import 'package:hendrix_today_app/screens/resource_screen.dart';

/// The root widget in the app widget hierarchy.
///
/// Changing the app's [ThemeMode] between light and dark and defining the app's
/// [Route]s is done here.
class RootApp extends StatefulWidget {
  const RootApp({super.key});

  /// Switches the app between a light and dark [ThemeMode].
  static void toggleTheme(BuildContext context) {
    // modified theme state solution from https://stackoverflow.com/a/67714404
    final stateWidget = context.findAncestorStateOfType<_RootAppState>();
    stateWidget?._toggleThemeMode();
  }

  @override
  State<RootApp> createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  /// The [ThemeMode] that determines how the app appears; defaults to
  /// [ThemeMode.system].
  ThemeMode _themeMode = ThemeMode.system;

  /// Toggles the [ThemeMode] for the app.
  ///
  /// If the current mode is [ThemeMode.system], it will change to either
  /// [ThemeMode.light] or [ThemeMode.dark] based on the opposite of the system
  /// settings; otherwise, it will toggle between light and dark normally.
  void _toggleThemeMode() {
    setState(() {
      switch (_themeMode) {
        case ThemeMode.dark:
          _themeMode = ThemeMode.light;
          break;
        case ThemeMode.light:
          _themeMode = ThemeMode.dark;
          break;
        case ThemeMode.system:
          final brightness = MediaQuery.of(context).platformBrightness;
          _themeMode =
              brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: hendrixTodayLightMode,
      darkTheme: hendrixTodayDarkMode,
      themeMode: _themeMode,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const HomeScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/login':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const LoginScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/calendar':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const CalendarScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/search':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const SearchScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          case '/resources':
            return PageRouteBuilder(
              settings: settings,
              pageBuilder: (_, __, ___) => const ResourcesScreen(),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            );
          default:
            return null;
        }
      },
      initialRoute: '/login',
      navigatorKey: navigatorKey,

      // The following legacy route code may be useful when reintroducing
      // a login system to the app:
      //
      // '/sign-in': ((context) {
      //   return SignInScreen(
      //     actions: [
      //       ForgotPasswordAction(((context, email) {
      //         Navigator.of(context)
      //             .pushNamed('/forgot-password', arguments: {'email': email});
      //       })),
      //       AuthStateChangeAction(((context, state) {
      //         if (state is SignedIn || state is UserCreated) {
      //           var user = (state is SignedIn)
      //               ? state.user
      //               : (state as UserCreated).credential.user;
      //           if (user == null) {
      //             return;
      //           }
      //           if (state is UserCreated) {
      //             user.updateDisplayName(user.email!.split('@')[0]);
      //           }
      //           if (!user.emailVerified) {
      //             user.sendEmailVerification();
      //             const snackBar = SnackBar(
      //                 content: Text(
      //                     'Please check your email to verify your email address'));
      //             ScaffoldMessenger.of(context).showSnackBar(snackBar);
      //           }
      //           Navigator.of(context).pushReplacementNamed('/home');
      //         }
      //       })),
      //     ],
      //   );
      // }),
      // '/forgot-password': ((context) {
      //   final arguments = ModalRoute.of(context)?.settings.arguments
      //       as Map<String, dynamic>?;

      //   return ForgotPasswordScreen(
      //     email: arguments?['email'] as String,
      //     headerMaxExtent: 200,
      //   );
      // }),
      // '/profile': ((context) {
      //   return ProfileScreen(
      //     actions: [
      //       SignedOutAction(
      //         ((context) {
      //           //Navigator.of(context).pushNamedAndRemoveUntil("/home", (r) => false)
      //           //to get rid of all previous pathing and return to the original route
      //           Navigator.of(context).pushReplacementNamed('/home');
      //         }),
      //       ),
      //     ],
      //   );
      // })
    );
  }
}
