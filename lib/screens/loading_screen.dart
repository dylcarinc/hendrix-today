import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 120,
                    width: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      elevation: 5,
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
                  ),
                  SizedBox(
                    height: 120,
                    width: 250,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      elevation: 5,
                      color: Theme.of(context).colorScheme.secondary,
                      child: ListTile(
                        minVerticalPadding: 10.0,
                        title: Text(
                          "community events, updates, and notices",
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          Container(
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
          ),
        ],
      ),
    );
  }
}
