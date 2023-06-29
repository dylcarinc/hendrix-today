import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_calendar.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/widgets/floating_nav_buttons.dart';

import 'package:provider/provider.dart';

//creates calendar page in app
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();

  void _updateSelectedDay(DateTime newSelectedDay) {
    setState(() {
      _selectedDay = newSelectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final eventList = appState.events
        .where((Event e) => e.matchesDate(_selectedDay))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "calendar",
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Column(
        children: [
          EventCalendar(onSelectDay: _updateSelectedDay),
          Expanded(
            child: EventList(events: eventList),
          ),
        ],
      ),
      floatingActionButton: const FloatingNavButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

// all of this will change. olivia is doing this.
