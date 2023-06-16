import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/event_calendar.dart';

//creates calendar page in app
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: EventCalendar());
  }
}

// all of this will change. olivia is doing this. 