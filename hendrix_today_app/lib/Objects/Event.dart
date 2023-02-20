import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AppState.dart';

class Event {
  final String? title;
  final String? desc;
  final String? time;
  final String? date; // change this to date
  List<String>? tags;

  Event({
    this.title,
    this.desc,
    this.time,
    this.date,
    this.tags,
  });
}

class EventList extends StatefulWidget {
  @override
  EventListState createState() => EventListState();
}

class EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: appState.events.length,
          itemBuilder: (context, index) {
            final item = appState.events[index];
            return Card(
              child: ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.date.toString()),
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    title: Text(item.title.toString()),
                    insetPadding:
                        EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                    content: Column(children: [Text(item.desc.toString())]),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

class EventList2 extends StatefulWidget {
  @override
  EventList2State createState() => EventList2State();
}

class EventList2State extends State<EventList2> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: appState.events2.length,
          itemBuilder: (context, index) {
            final item = appState.events2[index];
            return Card(
              child: ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.date.toString()),
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    title: Text(item.title.toString()),
                    insetPadding:
                        EdgeInsets.symmetric(vertical: 200, horizontal: 50),
                    content: Column(children: [Text(item.desc.toString())]),
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
