import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// A [ChangeNotifier] that keeps an up-to-date list of events from Firebase.
class AppState extends ChangeNotifier {
  StreamSubscription<QuerySnapshot>? _eventSubscription;
  List<Event> _events = [];

  /// The list of events, ordered by [Event.compareByDate].
  List<Event> get events => _events;

  AppState(this.auth, this.firestore) {
    _init();
  }
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  /// Listens for login and Firestore changes, updates the event list, then
  /// notifies listeners.
  Future<void> _init() async {
    auth.userChanges().listen((user) {
      _eventSubscription?.cancel();
      _eventSubscription = firestore
          .collection('events') //GV had .doc(user.uid); document ref
          .snapshots()
          .listen(
        (snapshot) {
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
