import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

/// Attempts to launch [url].
///
/// Fails if [url] is an invalid [Uri] or if the device does not support the
/// given type of URL (for example, attempting to launch a phone call on web).
Future<void> _tryLaunchUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) throw 'Could not launch $url: invalid URI';
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url: not supported according to `canLaunchUrl`';
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
          minVerticalPadding: 10.0,
          title: Text(
            titleString,
            style: Theme.of(context).textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          leading:
              Icon(icon, size: 60, color: Theme.of(context).iconTheme.color),
          onTap: () => _tryLaunchUrl(url),
        ),
      ),
    );
  }
}
