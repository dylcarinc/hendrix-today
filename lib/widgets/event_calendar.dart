import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';

import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

/// A container for the [TableCalendar] dependency.
///
/// See the [TableCalendar] source repo for more information:
/// https://github.com/aleksanderwozniak/table_calendar
class EventCalendar extends StatefulWidget {
  const EventCalendar({super.key, required this.onSelectDay});

  /// A callback called each time the user selects a calendar day.
  final void Function(DateTime) onSelectDay;

  @override
  State<EventCalendar> createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  /// Gets the events/announcements/etc. for the given day.
  List<HDXEvent> _getEventsForDay(DateTime day) {
    final appState = Provider.of<AppState>(context, listen: false);
    return appState.events
        .where((HDXEvent e) =>
            e.matchesDate(day) && e.inPostingRange(DateTime.now()))
        .toList();
  }

  /// Called when a day is selected on the [TableCalendar].
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
    for (HDXEvent e in appState.events) {
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
    for (HDXEvent e in appState.events) {
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
      headerStyle: HeaderStyle(
        leftChevronIcon: Icon(Icons.chevron_left,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
        rightChevronIcon: Icon(Icons.chevron_right,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black),
      ),
      calendarStyle: CalendarStyle(
          todayTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.primary),
          selectedDecoration:
              BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
          todayDecoration:
              BoxDecoration(color: Theme.of(context).colorScheme.secondary),
          markerDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
          ),
          markerSizeScale: 0.2),
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
        widget.onSelectDay(_selectedDay);
        setState(() {});
      },
    );
  }
}
