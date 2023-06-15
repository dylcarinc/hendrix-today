// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  List<Event> events = [];
  List<Event> searchResults = [];

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
                    onChanged: (searchQuery) => setState(() {
                      searchResults = events.where(
                        (e) => e.containsString(searchQuery)
                        ).toList();
                    }),
                    decoration: const InputDecoration(
                        labelText: 'Enter search query',
                        labelStyle: TextStyle(color: Colors.black),
                        focusColor: Color.fromARGB(255, 202, 81, 39),
                        suffixIcon: Icon(Icons.search),
                        iconColor: Colors.black),
                  ),
                ),
                searchResults.isNotEmpty
                  ? EventList(events: searchResults)
                  : const _EmptySearchLabel(),
              ],
            ),
          );
        }));
  }
}

class _EmptySearchLabel extends StatelessWidget {
  const _EmptySearchLabel();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text("There are no events containing that query."),
      ),
    );
  }
}
