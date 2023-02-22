import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:intl/intl.dart";

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

  String dateToString() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy');
    final String tmpdate = formatter.format(date ?? DateTime.now());
    return tmpdate;
  }
}
