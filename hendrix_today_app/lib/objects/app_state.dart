import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/firebase_options.dart';
import 'package:hendrix_today_app/objects/event.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide
        EmailAuthProvider,
        PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class AppState extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;
  num answer = 42;

  AppState() {
    init();
  }

  bool firstSnapshot = true;
  StreamSubscription<QuerySnapshot>? eventSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      eventSubscription?.cancel();
      debugPrint("starting to listen");
      eventSubscription = FirebaseFirestore.instance
          .collection('events') //GV had .doc(user.uid); document ref
          .snapshots()
          .listen(
        (snapshot) {
          debugPrint("in snapshot");
          _events = [];
          for (var document in snapshot.docs) {
            _events.add(Event(
              title: document.data()['title'],
              desc: document.data()['desc'],
              time: document.data()['time'],
              date: DateUtils.dateOnly(document.data()['date'].toDate()),
            ));
          }
          //  print(snapshot.docChanges.toString()); //prints changes
          firstSnapshot = false;
          notifyListeners();
        },
        onError: (error) {
          debugPrint(error);
        },
      );

      notifyListeners();
    });
  }
}
