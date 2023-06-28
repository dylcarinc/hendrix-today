// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/objects/theme_data.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';

import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";

  List<Event> _applySearchFilter(List<Event> events) =>
      events.where((Event e) => e.containsString(searchQuery)).toList();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final searchResults = _applySearchFilter(appState.events);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.htOrange,
        title: Text(
          "search",
          style: Theme.of(context).textTheme.htAppBarTitle,
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            key: const Key('daily_event_list'),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (newQuery) => setState(() {
                    searchQuery = newQuery;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Enter search query',
                      labelStyle: Theme.of(context).textTheme.htSearchBarLabel,
                      focusColor: Theme.of(context).colorScheme.htOrange,
                      suffixIcon: const Icon(Icons.search),
                      iconColor: Theme.of(context).colorScheme.htBlack),
                ),
              ),
              searchResults.isNotEmpty
                  ? EventList(events: searchResults)
                  : const _EmptySearchLabel(),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingNavButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
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
