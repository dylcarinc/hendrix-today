import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//initialize an instance of cloud firestore
final db = FirebaseFirestore.instance; //instance of the database
String userID = "";

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final String? date;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
  });

  factory Event.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Event(
      title: data?['title'],
      date: data?['date'],
      desc: data?['desc'],
      time: data?['time'],
    );
  }

  factory Event.getCurrentData(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final currentData = snapshot.data();
    return Event(
      title: currentData?['title'],
      date: currentData?['date'],
      desc: currentData?['desc'],
      time: currentData?['time'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (date != null) "date": date,
      if (time != null) "time": time,
      if (desc != null) "desc": desc,
    };
  }
}

Future getRef() async {
  final ref = db.collection("eventsListed").doc("event1").withConverter(
        fromFirestore: Event.fromFirestore,
        toFirestore: (Event event, _) => event.toFirestore(),
      );
  final docSnap = await ref.get();
  final event = docSnap.data(); // Convert to Event object
  if (event != null) {
    return (event);
  } else {
    return ("No such document.");
  }
}

//all of the dates should be formatted like 12/1/22
DateTime convertToDateTime(String stringDate) {
  List listDate = stringDate.split("/").map((x) => int.parse(x)).toList();
  return DateTime.utc(listDate[2], listDate[0], listDate[1]);
  //return DateTime.utc(year, month, day);
}

//should return a Future<Map<String, String>>
// this is the OG stuff that works
// is this even used. no. no it is not.
// getEvents() async {
//   Map dic = {};
//   final events = await db.collection('eventsListed').get();
//   for (var e in events.docs) {
//     //return (e.data())
//     Map d = e.data();
//     d.values.toString();
//     dic = d;
//   }
//   return dic;
// }

// maybe this is not where I should be working, maybe it is?
// getEvents() async {
//   Map dic = {};
//   DateTime eventDate;
//   final events = await db.collection('eventsListed').get();
//   for (var e in events.docs) {
//     eventDate = e.get('date');
//     if (eventDate.isAfter(DateTime.now())) {
//       Map d = e.data();
//       d.values.toString();
//       dic = d;
//     }
//   }
//   return dic;
// }

class UserInformation extends StatefulWidget {
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final Stream<QuerySnapshot> _usersStream =
      db.collection('eventslisted').snapshots();

  @override
  Widget build(BuildContext context) {
    var listViewChild;
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }
        listViewChild = snapshot.data!.docs
            .map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return ListTile(
                title: Text(data['title']),
                subtitle: Text(data['date']),
                trailing: Text('trail'),
              );
            })
            .toList()
            .cast();
        print('DOES IT EVER GET HERE');

        return ListView(
            children: //listViewChild,
                snapshot.data!.docs
                    .map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['title']),
                        subtitle: Text(data['date']),
                        //trailing: Text('trail'), doesnt come here
                      );
                    })
                    .toList()
                    .cast());
      },
    );
  }
}
