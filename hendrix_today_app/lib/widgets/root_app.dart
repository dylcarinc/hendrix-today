import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/theme_data.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';
import 'package:hendrix_today_app/screens/calendar_screen.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';
import 'package:hendrix_today_app/screens/resource_screen.dart';

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: hendrixTodayThemeData,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home': return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const HomeScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
          case '/calendar': return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const CalendarScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
          case '/search': return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const SearchScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
          case '/resources': return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => const ResourcesScreen(),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          );
          default: return null;
        }
      },
      initialRoute: '/home',

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
