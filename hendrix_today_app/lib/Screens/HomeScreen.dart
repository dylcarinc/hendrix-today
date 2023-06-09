import 'package:flutter/material.dart';

import '../Widgets/EventList.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Image.asset('assets/webOrange_banner.png',
                key: const Key("Banner")),
            EventList(),
          ],
        ));
  }
}
