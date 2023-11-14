import 'package:flutter/material.dart';
import 'resource_button.dart';

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
