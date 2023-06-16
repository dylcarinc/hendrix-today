import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/event_list.dart';
import 'package:hendrix_today_app/objects/app_state.dart';

import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final allEvents = Provider.of<AppState>(context).events;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            //Image.asset('assets/webOrange_banner.png',
            //    key: const Key("Banner")),
            EventList(events: allEvents),
          ],
        ));
  }
}
