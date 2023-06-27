import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key, required this.onSelectDay});
  final void Function(DateTime) onSelectDay;

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

//creation of the TableCalendar
//code obtained from TableCalendar repo: https://github.com/aleksanderwozniak/table_calendar
class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  /// Gets the events/announcements/etc. for the given day.
  List<Event> _getEventsForDay(DateTime day) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.events.where((Event e) => e.matchesDate(day)).toList();
  }

  /// Runs when a day is selected on the [TableCalendar].
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      widget.onSelectDay(selectedDay);
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
    }
  }

  /// Determines the earliest allowed date on the calendar.
  ///
  /// Because [TableCalendar.focusedDay] must be within the calendar's enabled
  /// range, it finds the earliest date among the focused day and all events.
  DateTime _getCalendarStartDate() {
    final appState = Provider.of<AppState>(context);
    DateTime min = _focusedDay;
    for (Event e in appState.events) {
      if (e.date.isBefore(min)) {
        min = e.date;
      }
    }
    return min;
  }

  /// Determines the latest allowed date on the calendar.
  ///
  /// Because [TableCalendar.focusedDay] must be within the calendar's enabled
  /// range, it finds the latest date among the focused day and all events.
  DateTime _getCalendarEndDate() {
    final appState = Provider.of<AppState>(context);
    DateTime max = _focusedDay;
    for (Event e in appState.events) {
      if (e.date.isAfter(max)) {
        max = e.date;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final earliest = _getCalendarStartDate();
    final latest = _getCalendarEndDate();
    final calendarStartDate = today.isBefore(earliest) ? today : earliest;
    final calendarEndDate = today.isAfter(latest) ? today : latest;

    return TableCalendar(
      firstDay: calendarStartDate,
      lastDay: calendarEndDate,
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      availableCalendarFormats: const {
        CalendarFormat.month: 'Month',
      },
      eventLoader: _getEventsForDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: _onDaySelected,
      onPageChanged: (focusedDay) {
        _selectedDay =
            DateTime(focusedDay.year, focusedDay.month, _selectedDay.day);
        _focusedDay = focusedDay;
        setState(() {});
      },
    );
  }
}
