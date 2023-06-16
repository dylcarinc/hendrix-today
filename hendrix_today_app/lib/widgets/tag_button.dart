import 'package:flutter/material.dart';

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
