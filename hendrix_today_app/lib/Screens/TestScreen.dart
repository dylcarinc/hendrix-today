// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart'; // new
import 'package:hendrix_today_app/Objects/Event.dart';

import '../Widgets/EventCard.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Event event = Event(
      title: "title",
      date: "date",
      desc: "desc",
      time: "time",
      tags: ["tag1", "tag2"]);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[EventList2(), EventCard(event: event)],
    );
  }
}
