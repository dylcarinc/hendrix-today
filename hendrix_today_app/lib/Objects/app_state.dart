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
      print("starting to listen");
      eventSubscription = FirebaseFirestore.instance
          .collection('events') //GV had .doc(user.uid); document ref
          .snapshots()
          .listen(
        (snapshot) {
          print("in snapshot");
          _events = [];
          snapshot.docs.forEach((document) {
            _events.add(Event(
              title: document.data()['title'],
              desc: document.data()['desc'],
              time: document.data()['time'],
              date: DateUtils.dateOnly(document.data()['date'].toDate()),
            ));
          });
          //  print(snapshot.docChanges.toString()); //prints changes
          firstSnapshot = false;
          notifyListeners();
        },
        onError: (error) {
          print(error);
        },
      );

      notifyListeners();
    });
  }

  List<Event> searchEvents(String searchQuery) {
    List<Event> results = [];
    if (searchQuery.isEmpty) {
      results = _events;
    } else {
      for (Event e in _events) {
        if (e.title!.toLowerCase().contains(searchQuery.toLowerCase()) |
            (e.desc!.toLowerCase().contains(searchQuery.toLowerCase()))) {
          results.add(e);
        }
      }
    }
    notifyListeners();
    return results;
  }
}
