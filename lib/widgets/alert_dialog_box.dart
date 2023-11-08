import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

class AlertDialogBox extends StatefulWidget {
  const AlertDialogBox({super.key, required this.url});
  final String url;
  @override
  State<AlertDialogBox> createState() => _AlertDialogBoxState(url: url);
}

class _AlertDialogBoxState extends State<AlertDialogBox> {
  _AlertDialogBoxState({required this.url});
  final String url;
  late bool _selected;

  @override
  void initState() {
    _selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //https://www.geeksforgeeks.org/flutter-outputting-widgets-conditionally/
    return (
      
      AlertDialog(
      title: const Text('This is an external link. Continue?'),
      actions: <Widget>[
        Column(
          children: [
            Row(
              children: [
                CheckboxExample(),
                Text("Don't show this again", style: TextStyle(fontSize:11 )),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 130.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => _tryLaunchUrl(url),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    ));
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
      return Colors.grey.shade300;
    }

    return Checkbox(
      checkColor: Colors.black,
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
