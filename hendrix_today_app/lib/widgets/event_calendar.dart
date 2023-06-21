import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';
import 'package:hendrix_today_app/widgets/event_list.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key});

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

//creation of the TableCalendar
//code obtained from TableCalendar repo: https://github.com/aleksanderwozniak/table_calendar
class _EventCalendarState extends State<EventCalendar> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  DateTime _focusedDay = DateTime.now();
  DateTime calendarRoot = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  /// Gets the events/announcements/etc. for the given day while also applying 
  /// relevant filters like the type filter dropdown on the app bar.
  List<Event> _getEventsForDay(DateTime day) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState
        .events
        .where((event) =>
          event.matchesDate(day) &&
          event.eventType == appState.eventTypeFilter)
        .toList();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final calendarStartDate = DateTime(today.year - 2, today.month, today.day);
    final calendarEndDate = DateTime(today.year, today.month + 1, today.day);
    return SizedBox(
      child: Consumer<AppState>(
        builder: (context, appState, _) {
          return Column(
            children: [
              TableCalendar(
                firstDay: calendarStartDate,
                lastDay: calendarEndDate,
                focusedDay: _focusedDay,
                calendarFormat: CalendarFormat.month,
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                },
                eventLoader: _getEventsForDay,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.
                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: _onDaySelected,
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _selectedDay = DateTime(
                      focusedDay.year, focusedDay.month, _selectedDay.day);
                  _focusedDay = focusedDay;
                  _selectedEvents.value = _getEventsForDay(_selectedDay);
                  setState(() {});
                },
                onCalendarCreated: (pageController) {
                  _selectedEvents.value = _getEventsForDay(_selectedDay);
                },
              ),
              //EventList()
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, events, _) => EventList(events: events),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
