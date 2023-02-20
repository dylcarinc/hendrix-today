// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

import '../Objects/Event.dart';

class EventCard extends StatelessWidget {
  void search() {
    //placeholder
  }
  EventCard({required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
      children: [
        Expanded(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 12, 10, 2),
              child: Text(
                event.title.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
              child: Text(
                event.date.toString(),
                style: TextStyle(
                    fontSize: 14, color: Colors.black.withOpacity(.6)),
              ),
            )
          ]),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              for (var i = 0; i < event.tags!.length; i++)
                TagButton(onPressed: search, btnText: event.tags!.elementAt(i)),
            ],
          ),
        )
      ],
    ));
  }
}

class TagButton extends StatelessWidget {
  TagButton({required this.onPressed, required this.btnText});

  final String btnText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 30,
      child: ElevatedButton(
        onPressed: () {
          // search for things w/ that tag
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 255, 165, 86)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)))),
        child: Text(
          btnText,
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
    );
  }
}
