// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // new
import 'package:hendrix_today_app/Objects/Event.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  TextEditingController textController = TextEditingController();

  List<String> events = [];
  List<String> searchedEvents = [];

  @override
  initState() {
    searchedEvents = events;
    super.initState();
  }

  void runFilter(String query) {
    List<String> results = [];
    if (query.isEmpty) {
      results = events;
    } else {
      for (String event in events) {
        if (event.toLowerCase().contains(query.toLowerCase())) {
          results.add(event);
        }
      }
    }

    setState(() {
      searchedEvents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        key: const Key('daily_event_list'),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Enter search query',
                  suffixIcon: Icon(Icons.search)),
            ),
          ),
          ListBody(
            children: [EventList()],
          )
        ],
      ),
    );
  }
}
