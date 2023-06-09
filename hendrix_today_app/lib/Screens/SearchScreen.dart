// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart'; // new
import 'package:hendrix_today_app/Objects/AppState.dart';
import 'package:provider/provider.dart';
import '../Objects/Event.dart';
import '../Widgets/EventList.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  TextEditingController textController = TextEditingController();
  List<Event> events = [];
  List<Event> results = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
        create: (context) => AppState(),
        child: Consumer<AppState>(builder: (context, appState, child) {
          events = appState.events;
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ListView(
              key: const Key('daily_event_list'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      results = appState.searchEvents(value);
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                        labelText: 'Enter search query',
                        labelStyle: TextStyle(color: Colors.black),
                        focusColor: Color.fromARGB(255, 202, 81, 39),
                        suffixIcon: Icon(Icons.search),
                        iconColor: Colors.black),
                  ),
                ),
                showResults(results)
              ],
            ),
          );
        }));
  }
}

Widget showResults(List<Event> results) {
  if (results.isEmpty) {
    return Text("There are no events containing that query. ");
  } else {
    return ListView.builder(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      itemCount: results.length,
      itemBuilder: (context, index) {
        return EventCard(event: results[index]);
      },
    );
  }
}
