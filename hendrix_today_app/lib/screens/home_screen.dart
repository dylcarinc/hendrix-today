import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event_type.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  EventTypeFilter eventTypeFilter = EventTypeFilter.all;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final homePageEvents = appState.events
        .where(
          (event) =>
              event.eventType.matchesFilter(eventTypeFilter) &&
              event.inPostingRange(DateTime.now()),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "hendrix today",
          style: Theme.of(context).textTheme.displayLarge,
        ),
        actions: [
          _FilterDropdown(
            initialValue: eventTypeFilter,
            onChanged: (newFilterChoice) => setState(() {
              eventTypeFilter = newFilterChoice ?? eventTypeFilter;
            }),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              EventList(events: homePageEvents),
            ],
          ),
        ),
      ),
      floatingActionButton: const FloatingNavButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({required this.initialValue, required this.onChanged});
  final EventTypeFilter initialValue;
  final void Function(EventTypeFilter?) onChanged;

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<EventTypeFilter>> dropdownItems =
        EventTypeFilter.values
            .map((etf) => DropdownMenuItem(
                  value: etf,
                  child: Text(
                    etf.toString(),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ))
            .toList();

    return DropdownButtonHideUnderline(
      key: const Key('EventTypeFilterDropdown'),
      child: DropdownButton<EventTypeFilter>(
        value: initialValue,
        dropdownColor: Theme.of(context).colorScheme.primary,
        items: dropdownItems,
        onChanged: onChanged,
      ),
    );
  }
}
