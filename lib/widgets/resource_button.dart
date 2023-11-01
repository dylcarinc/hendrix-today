import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:auto_size_text/auto_size_text.dart'; //https://pub.dev/packages/auto_size_text

import 'external_link_alert.dart';

/// Attempts to launch [url].
///
/// Fails if [url] is an invalid [Uri] or if the device does not support the
/// given type of URL (for example, attempting to launch a phone call on web).
Future<String> _tryLaunchUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return 'Could not launch $url: invalid URI';
  }
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    return "Success!";
  } else {
    return 'Could not launch $url: not supported according to `canLaunchUrl`';
  }
}

/// A large button that links to a URL.
class ResourceButton extends StatelessWidget {
  const ResourceButton({
    super.key,
    required this.titleString,
    required this.icon,
    required this.url,
    required this.color,
  });

  /// A short title to be displayed on the button.
  final String titleString;

  /// The type of [Icon] to be displayed to the left of the title.
  final IconData icon;

  /// The URL to which this button should link.
  ///
  /// See [_launchUrl] for details on the launch process.
  final String url;

  /// The background [Color] of the button.
  ///
  /// Use colors from the current [ThemeData]'s [ColorScheme] to match the rest
  /// of the app.
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 300,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        elevation: 5,
        color: color,
        child: ListTile(
            minVerticalPadding: 30.0,
            title: AutoSizeText(
              // new addition here
              maxFontSize: 20,
              titleString,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            leading:
                Icon(icon, size: 60, color: Theme.of(context).iconTheme.color),
            onTap: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => ExternalLinkDialog()
/*            _tryLaunchUrl(url).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                    )));
                    */

            ),
      ),
    ));
  }
}

class ExternalLinkDialog extends StatefulWidget {
  const ExternalLinkDialog({super.key});

  @override
  State<ExternalLinkDialog> createState() => _ExternalLinkDialogState();
}

class _ExternalLinkDialogState extends State<ExternalLinkDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('This is an external link. Continue?'),
      actions: <Widget>[
        Row(
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('OK'),
            ),
          ],
        ),
        Text("Disable?"),
        CheckboxExample()
      ],
    );
  }
}

class CheckboxExample extends StatefulWidget {
  const CheckboxExample({super.key});

  @override
  State<CheckboxExample> createState() => _CheckboxExampleState();
}

class _CheckboxExampleState extends State<CheckboxExample> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.white38;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}
