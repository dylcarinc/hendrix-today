import 'package:intl/intl.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final DateTime? date; // change this to date
  List<String>? tags;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
    this.tags,
  });

  factory Event.fromFirebase(Map<String, dynamic> data) {
    throw UnimplementedError();
  }

  String dateToString() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String tmpdate = formatter.format(date ?? DateTime.now());
    return tmpdate;
  }
}
