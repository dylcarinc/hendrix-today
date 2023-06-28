import 'package:flutter/material.dart';

import 'package:hendrix_today_app/objects/theme_data.dart';

class FloatingNavButtons extends StatelessWidget {
  /// The navigation buttons for the app.
  ///
  /// Use this in the place of a [Scaffold.floatingActionButton] and ensure that
  /// the [Scaffold.floatingActionButtonLocation] is set to
  /// [FloatingActionButtonLocation.centerFloat].
  const FloatingNavButtons({super.key});

  /// Replaces the current route with [toRoute], unless it is the current route.
  void _navigate(BuildContext context, String toRoute) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute == toRoute) return;
    Navigator.pushReplacementNamed(context, toRoute);
  }

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
              heroTag: null, // See https://stackoverflow.com/q/51125024
              onPressed: () => _navigate(context, '/home'),
              backgroundColor: Theme.of(context).colorScheme.htOrange,
              child: const Icon(Icons.home),
            )),
        // button second
        Container(
            key: const Key('CalendarButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              heroTag: null,
              onPressed: () => _navigate(context, '/calendar'),
              backgroundColor: Theme.of(context).colorScheme.htBlack,
              child: const Icon(Icons.calendar_month),
            )),
        // button third
        Container(
            key: const Key('SearchButton'),
            margin: const EdgeInsets.all(10),
            child: FloatingActionButton.small(
              heroTag: null,
              onPressed: () => _navigate(context, '/search'),
              backgroundColor: Theme.of(context).colorScheme.htOrange,
              child: const Icon(Icons.search),
            )),
        Container(
          key: const Key('ResourcesPage'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/resources'),
            backgroundColor: Theme.of(context).colorScheme.htGray,
            child: const Icon(Icons.food_bank),
          ),
        ),
      ],
    );
  }
}
