// a lot of code was written with the help of this video: https://www.youtube.com/watch?v=pUV5v240po0&ab_channel=dbestech
import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';

import 'package:provider/provider.dart';

/// A search page to easily find events.
///
/// This screen behaves similar to the home page except displays all events by
/// default and uses a search field rather than a dropdown filter menu to filter
/// events.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  /// The search term to be applied to the results list; is empty by default.
  String searchQuery = "";

  List<HDXEvent> _applySearchFilter(List<HDXEvent> events) => events
      .where((HDXEvent e) =>
          e.containsString(searchQuery) && e.inPostingRange(DateTime.now()))
      .toList();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final searchResults = _applySearchFilter(appState.events);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "search",
          style: Theme.of(context).textTheme.displayMedium,
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
                  key: const Key('SearchInput'),
                  onChanged: (newQuery) => setState(() {
                    searchQuery = newQuery;
                  }),
                  decoration: InputDecoration(
                      labelText: 'Enter search query',
                      labelStyle: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.copyWith(
                              color: Theme.of(context).colorScheme.tertiary),
                      focusColor: Theme.of(context).colorScheme.primary,
                      suffixIcon: const Icon(Icons.search),
                      iconColor: Theme.of(context).colorScheme.secondary),
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

/// A helper widget that displays a "no results found" message when the search
/// query finds no matching events.
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
