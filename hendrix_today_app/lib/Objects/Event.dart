import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final String? date; // change this to date
  List<String>? tags;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
    this.tags,
  });
}
