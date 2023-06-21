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
  EventType _eventTypeFilter = EventType.announcement;
  EventType get eventTypeFilter => _eventTypeFilter;
  
  void updateEventTypeFilter(String? s) {
    final maybeEventType = EventType.fromString(s);
    if (maybeEventType != null) {
      _eventTypeFilter = maybeEventType;
      notifyListeners();
    }
  }

  AppState() {
    init();
  }

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
            final Map<String, dynamic> data = document.data();
            final Event? event = Event.fromFirebase(data);
            if (event != null) {
              _events.add(event);
            } else {
              debugPrint("Throwing away invalid event data: $data");
            }
          }
          // establishes a default sort order
          _events.sort((Event a, Event b) => a.compareByDate(b));
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
