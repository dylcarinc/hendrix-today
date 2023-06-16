import 'package:flutter/material.dart';
import 'package:hendrix_today_app/screens/calendar_screen.dart';

import 'package:hendrix_today_app/screens/resource_screen.dart';
import 'package:hendrix_today_app/screens/search_screen.dart';
import 'package:hendrix_today_app/screens/home_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class ScreenContainer extends StatefulWidget {
  const ScreenContainer({super.key});

  @override
  State<ScreenContainer> createState() => _ScreenContainerState();
}

class _ScreenContainerState extends State<ScreenContainer> {
  Color webOrange = const Color.fromARGB(255, 202, 81, 39);
  int selectedIndex = 0;
  List<Widget> pages = []; //contains each page
  List<String> titles = [];
  List<String> menuLinks = []; //contains the title of each page
  final List<String> dropdownItems = [
    "events",
    "announcements",
    "meetings",
  ];
  String dropdownValue = "events";

  @override
  void initState() {
    super.initState();
    pages = [
      const MyHomeScreen(),
      const CalendarScreen(),
      const SearchScreen(),
      const ResourcesScreen(),
    ];
    titles = [
      "hendrix today",
      "calendar",
      "search",
      "resources",
    ];
    menuLinks = [
      "https://www.hendrix.edu/diningservices/default.aspx?id=1003",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1004",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1005",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1006",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1007",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1008",
      "https://www.hendrix.edu/diningservices/default.aspx?id=1002"
    ];
  }

  _launchURLApp() async {
    int dayOfWeek = DateTime.now().weekday;
    String menuLink = menuLinks[dayOfWeek - 1];
    Uri menuUrl = Uri.parse(menuLink);
    if (await canLaunchUrl(menuUrl)) {
      await launchUrl(menuUrl);
    } else {
      throw 'Could not launch $menuUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: webOrange,
        title: Text(titles[selectedIndex],
            style: const TextStyle(
              fontFamily: 'MuseoBold',
              fontSize: 30,
            )),
        //     leading: IconButton(
        //       onPressed: () => Navigator.pushNamed(context, "/sign-in"),
        //       icon: const Icon(Icons.account_circle)),
        actions: [
          selectedIndex < 2
              ? DropdownButton<String>(
                  value: dropdownValue,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: webOrange,
                  items: dropdownItems.map((itemone) {
                    return DropdownMenuItem(
                        value: itemone,
                        child: Text(itemone,
                            style: const TextStyle(
                              fontFamily: 'Museo',
                              fontSize: 15,
                            )));
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue.toString();
                    });
                  },
                )
              : Container(),
        ],
      ),
      body: Center(child: pages[selectedIndex]),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.horizontal, //use vertical to show  on vertical axis
        children: <Widget>[
          //button first
          Container(
              key: const Key('HomeButton'),
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () => onItemTapped(0),
                backgroundColor: Colors.deepOrangeAccent,
                child: const Icon(Icons.home),
              )),
          // button second
          Container(
              key: const Key('CalendarButton'),
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () => onItemTapped(1),
                backgroundColor: Colors.black87,
                child: const Icon(Icons.calendar_month),
              )),
          // button third
          Container(
              key: const Key('SearchButton'),
              margin: const EdgeInsets.all(10),
              child: FloatingActionButton.small(
                onPressed: () => onItemTapped(2),
                backgroundColor: Colors.teal,
                child: const Icon(Icons.search),
              )),
          Container(
            key: const Key('MenuButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
                onPressed: _launchURLApp,
                backgroundColor: const Color.fromARGB(255, 162, 131, 102),
                child: const Icon(Icons.food_bank)),
          ),
          Container(
            key: const Key('ResourcesPage'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              onPressed: () => onItemTapped(3),
              backgroundColor: Colors.blueGrey,
              child: const Icon(Icons.question_mark),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  //Stores Page Titles for AppBar

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
