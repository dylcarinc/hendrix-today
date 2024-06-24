import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationCheck extends StatefulWidget {
  const NotificationCheck({super.key});

  @override
  State<NotificationCheck> createState() => _NotificationCheckState();
}

class _NotificationCheckState extends State<NotificationCheck> {
  late Future<bool> notified;

  Future<bool> determineNotification() async {
    var status = await Permission.notification.status;
    if (status.isDenied) {
      // We haven't asked for permission yet or the permission has been denied before, but not permanently.
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    notified = determineNotification().then((bool noted) {
      return noted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: notified,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Text("Waiting...");
            case ConnectionState.active:
            case ConnectionState.done:
              if (snapshot.hasError) {
                return const Text("Error!");
              } else {
                if (snapshot.data == true) {
                  return const Text("Hooray!");
                } else {
                  return const Text("Boo, please turn on Notifications.");
                }
              }
          }
        });
  }
}
