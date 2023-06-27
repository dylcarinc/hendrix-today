import 'package:flutter/material.dart';

/// The navigation buttons for the app.
///
/// Use this in the place of a [Scaffold.floatingActionButton] and ensure that
/// the [Scaffold.floatingActionButtonLocation] is set to
/// [FloatingActionButtonLocation.centerFloat].
class FloatingNavButtons extends StatelessWidget {
  const FloatingNavButtons({super.key, required this.thisPageRoute});
  final String thisPageRoute;

  final Color webOrange = const Color.fromARGB(255, 202, 81, 39);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: [
        //button first
        Container(
            key: const Key('HomeButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/home',
              ),
              backgroundColor: webOrange,
              child: const Icon(Icons.home),
            )),
        // button second
        Container(
            key: const Key('CalendarButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/calendar',
              ),
              backgroundColor: Colors.black87,
              child: const Icon(Icons.calendar_month),
            )),
        // button third
        Container(
            key: const Key('SearchButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/search',
              ),
              backgroundColor: const Color.fromARGB(255, 162, 131, 102),
              child: const Icon(Icons.search),
            )),
        Container(
          key: const Key('ResourcesPage'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            onPressed: () => Navigator.pushReplacementNamed(
                context,
                '/resources',
              ),
            backgroundColor: Colors.blueGrey,
            child: const Icon(Icons.food_bank),
          ),
        ),
      ],
    );
  }
}
