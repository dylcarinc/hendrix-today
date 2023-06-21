import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';

class RichDescription extends StatelessWidget {
  const RichDescription({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Html(
      data: text,
      onLinkTap: (url, _, __) async {
        if (url == null) return;
        final uri = Uri.tryParse(url);
        if (uri == null ) return;
        if (!await canLaunchUrl(uri)) return;
        launchUrl(uri, mode: LaunchMode.externalApplication);
        // if this doesn't work, maybe try https://pub.dev/packages/flutter_widget_from_html
      },
    );
  }
}