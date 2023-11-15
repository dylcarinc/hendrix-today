import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:auto_size_text/auto_size_text.dart'; //https://pub.dev/packages/auto_size_text
import 'alert_dialog_box.dart';

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

  dialogOrLaunch(context, url) async {
    bool doNotShow = await DoNotShowBox.getCheckBox();
    if (doNotShow == false) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialogBox(url: url));
    } else {
      _tryLaunchUrl(url);
    }
  }

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
            onTap: () {
              //if the checkbox is checked then don't build this alertdialog box
              dialogOrLaunch(context, url);
            }),
      ),
    );
  }
}

/*            _tryLaunchUrl(url).then(
                (value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                    )));
                    */
