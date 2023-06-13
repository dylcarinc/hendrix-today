import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/app_state.dart';
import 'package:hendrix_today_app/objects/event.dart';

import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class EventList extends StatefulWidget {
  const EventList({super.key});

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
          physics: const ScrollPhysics(),
          itemCount: appState.events.length,
          itemBuilder: (context, index) {
            final item = appState.events[index];
            return Card(
              child: ListTile(
                title: Text(item.title.toString()),
                subtitle: Text(item.date.toString()),
                onTap: () {
                  AlertDialog alert = AlertDialog(
                    scrollable: true,
                    title: Text(item.title.toString()),
                    insetPadding: const EdgeInsets.symmetric(
                      vertical: 100,
                      horizontal: 50
                    ),
                    content: Column(children: [Text(item.desc.toString())]),
                    actions: <Widget>[
                      IconButton(
                        color: Colors.black,
                        onPressed: () {
                          Navigator.pop(context);
                          Share.share('"${item.title}" -${item.desc}',
                            subject: 'Check out this quote!');
                        },
                        icon: const Icon(Icons.share_outlined)
                      ),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => alert,
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

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final Event event;

  @override
  Widget build(BuildContext context) {
    List<Widget> tagButtonList = [];
    
    if (event.tags != null && event.tags!.isNotEmpty) {
      for (var i = 0; i < event.tags!.length; i++) {
        tagButtonList.add(
          TagButton(
            onPressed: (){}, // TODO apply tag filter
            btnText: event.tags!.elementAt(i)
          ));
      }
    }

    return GestureDetector(
      child: Card(
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
                    style: const TextStyle(
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
              ]
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ButtonBar(
              alignment: MainAxisAlignment.end,
              children: tagButtonList,
            ),
          )
        ],
      )),
      onTap: () {
        AlertDialog alert = AlertDialog(
          title: Text(event.title.toString()),
          insetPadding: const EdgeInsets.symmetric(
            vertical: 200,
            horizontal: 50
          ),
          content: Column(children: [
            Text(event.desc.toString()),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ButtonBar(
                alignment: MainAxisAlignment.end,
                children: tagButtonList,
              ),
            ),
          ]),
        );
        showDialog(
          context: context,
          builder: (BuildContext context) => Column(
            children: [
              alert,
            ],
          ),
        );
      },
    );
  }
}

class TagButton extends StatelessWidget {
  const TagButton({super.key, required this.onPressed, required this.btnText});

  final String btnText;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height / 30,
      child: ElevatedButton(
        onPressed: onPressed,
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

 //  ```````````````````````````````` 
 // my dog put her paw on by keyboard and wrote that.  who am i to tell her she cant code. 
