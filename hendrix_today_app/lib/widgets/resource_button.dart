import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_launchURL(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class ResourceButton extends StatelessWidget {
  const ResourceButton({
    super.key,
    required this.titleString,
    required this.icon,
    required this.url,
    required this.color,
  });

  final String titleString;
  final IconData icon;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 100,
        width: 300,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            elevation: 5,
            color: color, //Colors.orange[200],
            child: ListTile(
              minVerticalPadding: 10.0,
              title: Text(
                titleString,
                style: const TextStyle(
                    fontSize: 30, color: Colors.white, fontFamily: "MuseoBold"),
                textAlign: TextAlign.center,
              ),
              leading: Icon(icon, size: 60, color: Colors.white),
              onTap: () => _launchURL(url),
            )));
  }
}
