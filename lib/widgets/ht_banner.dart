import 'package:flutter/material.dart';

class HTBanner extends StatelessWidget {
  const HTBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
      elevation: 5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 120,
            width: 250,
            color: Theme.of(context).colorScheme.primary,
            child: ListTile(
              minVerticalPadding: 10.0,
              title: Text(
                "hendrix today",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Container(
            height: 120,
            width: 250,
            color: Colors.white,
            child: ListTile(
              minVerticalPadding: 10.0,
              title: Text(
                "community events, updates, and notices",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
