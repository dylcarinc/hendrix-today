// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'firebase.dart' as fb;

var daily_events_list;
var daily_announcements_list;
var daily_meetings_list;

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

//got the code for below from: https://firebase.google.com/docs/firestore/query-data/listen#dart_1

class _MyHomeScreenState extends State<MyHomeScreen> {
  final Stream<QuerySnapshot> _usersStream =
      fb.db.collection('eventsListed').snapshots();

  @override
  Widget build(BuildContext context) {
    DateTime convertToDateTime(String stringDate) {
      List listDate = stringDate.split("/").map((x) => int.parse(x)).toList();
      return DateTime.utc(listDate[2], listDate[0], listDate[1]);
      //return DateTime.utc(year, month, day);
    }

    //builds a snapshot of Firebase at the time its called
    //houses the snapshot in _usersStream
    DateTime eventDate;
    DateTime newYear = DateTime.utc(2023, 1, 1);
    //   List listDate = stringDate.split("/").map((x) => int.parse(x)).toList();

    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            key: const Key('daily_events_list'),
            children: <Widget>[
              //hendrix today banner
              Image.asset('assets/webOrange_banner.png',
                  key: const Key("Banner")),
              ListBody(
                  //pulls data (events) from snapshot and converts to map
                  //then converts to list
                  //then converts to card
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        // data.values.forEach((element) {
                        //  eventDate = convertToDateTime(element["date"]);
                        // var temp = element
                        //eventDate = convertToDateTime(element);
                        // if (eventDate.isAfter(newYear)) {
                        //   data.remove(element);
                        // }
                        //   });
                        // for (var e in data.entries) {
                        //   eventDate =

                        //       // map.keys.forEach((k)
                        //       // var temp = convertToDateTime(e.["date"]);
                        //       eventDate = DateTime.now();
                        //   // eventDate = convertToDateTime(data["date"]);
                        //   if (eventDate.isBefore(DateTime.now())) {
                        //     data.remove(e);
                        //   }
                        // }
                        // if eventDate isAfter now
                        //delete from snapshot
                        //  if (data["date"]) ;
                        return Card(
                            elevation: 6.0,
                            child: ListTile(
                              title: Text(data["title"]),
                              subtitle: Text(data["date"]),
                              trailing: Text("3"),
                              onTap: () {
                                AlertDialog alert = AlertDialog(
                                  title: Text(data["title"]),
                                  insetPadding: EdgeInsets.symmetric(
                                      vertical: 200, horizontal: 50),
                                  content:
                                      Column(children: [Text(data["desc"])]),
                                );

                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return alert;
                                  },
                                );
                              },
                            ));
                      })
                      .toList()
                      .cast()),
            ],
          ),
        );
      },
    );
  }
}
