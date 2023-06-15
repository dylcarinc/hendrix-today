import 'dart:async';
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/event.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppState extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  AppState(this.auth, this.firestore) {
    init();
  }

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  bool firstSnapshot = true;
  StreamSubscription<QuerySnapshot>? eventSubscription;

  Future<void> init() async {

    auth.userChanges().listen((user) {
      eventSubscription?.cancel();
      debugPrint("starting to listen");
      eventSubscription = firestore
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
              date: DateUtils.dateOnly(
                (document.data()['date'] as Timestamp).toDate()),
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
