import 'package:flutter/material.dart';
import 'package:hendrix_today_app/widgets/root_app.dart';

class ToggleBar extends StatelessWidget {
  const ToggleBar({
    super.key,
    required this.titleString,
    required this.icon,
    required this.color,
  });

  /// A short title to be displayed on the button.
  final String titleString;

  /// The type of [Icon] to be displayed to the left of the title.
  final IconData icon;

  /// The background [Color] of the button.
  ///
  /// Use colors from the current [ThemeData]'s [ColorScheme] to match the rest
  /// of the app.
  final Color color;

  @override
  Widget build(BuildContext context) {
    bool darkmode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 60,
      width: 300,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
          elevation: 5,
          color: color,
          child: SwitchListTile(
            title: Text(
              titleString,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            value: darkmode,
            onChanged: (bool value) => RootApp.toggleTheme(context),
            secondary: Icon(icon, color: Theme.of(context).iconTheme.color),
          )),
    );
  }
}
