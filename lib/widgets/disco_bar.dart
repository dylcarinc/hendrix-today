import 'package:flutter/material.dart';

class DiscoBar extends StatelessWidget {
  const DiscoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "built by",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Disco Tray Studios",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          Theme.of(context).brightness == Brightness.dark
              ? Image.asset('assets/DiscoLogoSmallWhite.png')
              : Image.asset('assets/DiscoLogoSmallBlack.png'),
        ],
      ),
    );
  }
}
