import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hendrix_today_app/Objects/Event.dart';
import 'package:hendrix_today_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // new
import 'package:firebase_auth/firebase_auth.dart' // new
    hide
        EmailAuthProvider,
        PhoneAuthProvider; // new
import 'package:firebase_core/firebase_core.dart'; // new
import 'package:firebase_ui_auth/firebase_ui_auth.dart'; // new

//github please acknowledge this file

final db =
    FirebaseFirestore.instance; //instance of the database (delete eventually)
String userID = "";
// for later: Good Vibes has good sign in/register/sign out/verification

class AppState extends ChangeNotifier {
  List<Event> _events = [];
  List<Event> get events => _events;

  AppState() {
    // put database helper here if needed (moodDbHelper/handler)
    // notification servive (?)
    // settings (?)
    init();
  }

  bool _loggedIn = false; // ours
  bool get loggedIn => _loggedIn; //ours

  bool firstSnapshot = true;
  StreamSubscription<QuerySnapshot>? eventSubscription;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        eventSubscription?.cancel(); //WHY?
        // cacheUsersAndMoods

        print("starting to listen");
        eventSubscription = FirebaseFirestore.instance
            .collection('eventsListed') //GV had .doc(user.uid); document ref
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
                date: document.data()['date'],
              ));
            });
            print(snapshot.docChanges.toString()); //prints changes
            // GV looks for new Good Vibes to notify the user
            firstSnapshot = false;
            notifyListeners();
          },
          onError: (error) {
            print(error);
          },
        );
      } else {
        _loggedIn = false; // _loginState = ApplicationLoginState.loggedOut;
        _events = [];

        eventSubscription?.cancel();
      }
      notifyListeners();
    });

    /* 
    void cacheEvents() -- for GV: (get 50 most recent, update mood map)
      FirebaseFirestore.instance
      .collection('collection')
      .orderBy(order)
      .limit(limit)
      .get()
      .then((data) {
        for GV: update moodMap
      }
      notifyListeners();
     */
  }
}
