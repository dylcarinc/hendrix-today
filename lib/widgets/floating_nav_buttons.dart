import 'package:flutter/material.dart';

import 'package:hendrix_today_app/widgets/root_app.dart';

/// A horizontal bar of navigation buttons.
///
/// Use this in the place of a [Scaffold.floatingActionButton]. Meant to be used
/// with [FloatingActionButtonLocation.centerFloat].
class FloatingNavButtons extends StatelessWidget {
  const FloatingNavButtons({super.key});

  /// Replaces the current route with [toRoute] unless they are the same.
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
        Container(
          key: const Key('HomeButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null, // See https://stackoverflow.com/q/51125024
            onPressed: () => _navigate(context, '/home'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.home),
          ),
        ),
        Container(
          key: const Key('CalendarButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/calendar'),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: const Icon(Icons.calendar_month),
          ),
        ),
        Container(
          key: const Key('SearchButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/search'),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.search),
          ),
        ),
        Container(
          key: const Key('ResourcesButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/resources'),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            child: const Icon(Icons.info_outline),
          ),
        ),
      ],
    );
  }
}
