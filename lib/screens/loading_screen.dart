import 'package:flutter/material.dart';
import '../widgets/disco_bar.dart';
import '../widgets/ht_banner.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HTBanner(),
          CircularProgressIndicator(),
          DiscoBar(),
        ],
      ),
    );
  }
}
