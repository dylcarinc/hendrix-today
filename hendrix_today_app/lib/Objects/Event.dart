import 'package:cloud_firestore/cloud_firestore.dart';

//initialize an instance of cloud firestore

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
