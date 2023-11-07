import 'package:flutter/material.dart';

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

  /// Changes the Floating Nav Button to be Orange on the Current Page
  /// Yes, I know that the check is rudimentary, but the current amount of
  /// pages draws a thin line between having to make a new
  /// data structure and not. So, for now this will be the solution.
  _currentPage(context, String thisPage) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != '/home' &&
        currentRoute != '/calendar' &&
        currentRoute != '/resources' &&
        thisPage == '/home') {
      return Theme.of(context).colorScheme.primary;
    } else if (currentRoute == thisPage) {
      return Theme.of(context).colorScheme.primary;
    } else {
      Theme.of(context).colorScheme.tertiary;
    }
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
            backgroundColor: _currentPage(context, '/home'),
            child: const Icon(Icons.home),
          ),
        ),
        Container(
          key: const Key('CalendarButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/calendar'),
            backgroundColor: _currentPage(context, '/calendar'),
            child: const Icon(Icons.calendar_month),
          ),
        ),
        Container(
          key: const Key('ResourcesButton'),
          margin: const EdgeInsets.all(10),
          child: FloatingActionButton.small(
            heroTag: null,
            onPressed: () => _navigate(context, '/resources'),
            backgroundColor: _currentPage(context, '/resources'),
            child: const Icon(Icons.info_outline),
          ),
        ),
      ],
    );
  }
}
