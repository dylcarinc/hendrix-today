import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' show Document, Node;
import 'package:url_launcher/url_launcher.dart';

/// Attempts to launch [url].
///
/// Silently fails if [url] is `null` or an invalid [Uri] or if the device does
/// not support the given type of URL (for example, a phone call on the web).
Future<void> _tryLaunchUrl(String? url) async {
  if (url == null) return;
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  if (!await canLaunchUrl(uri)) return;
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

/// A helper class containing rich text data for plain text or hyperlinks.
class _RichTextItem {
  const _RichTextItem(this.text, {String? link}) : _link = link;
  final String text;
  final String? _link;
  String? get link => _link;
  bool get isLink => _link != null;
}

class RichDescription extends StatelessWidget {
  const RichDescription({super.key, required this.text});
  final String text;

  /// Converts a [_RichTextItem] to a [TextSpan].
  ///
  /// If the item has a link, the [TextSpan] will have a [TapGestureRecognizer]
  /// that will open the associated link on tap.
  TextSpan _richTextToWidget(BuildContext context, _RichTextItem item) {
    return item.isLink
        ? TextSpan(
            text: item.text,
            style: Theme.of(context).textTheme.labelSmall,
            // https://stackoverflow.com/a/50011168 for TextSpan onTap
            recognizer: TapGestureRecognizer()
              ..onTap = () => _tryLaunchUrl(item.link),
          )
        : TextSpan(
            text: item.text,
            style: Theme.of(context).textTheme.bodySmall,
          );
  }

  /// Parses the HTML in [text] into a [List] of [_RichTextItem]s.
  ///
  /// The parser treats [text] as an HTML document and only includes text
  /// [Node]s and anchor [Element]s with `href` attributes.
  List<_RichTextItem> _parseRichDescription() {
    final List<_RichTextItem> rtItems = [];
    final Document doc = parse(text);
    final Node body = doc.body!;

    // remove all non-anchor tags (for safety)
    body.children.removeWhere((e) => e.localName != "a");

    while (body.hasChildNodes()) {
      final Node child = body.firstChild!;
      final String text = child.text ?? "";

      if (child.nodeType == Node.TEXT_NODE) {
        rtItems.add(_RichTextItem(text));
      } else if (child.nodeType == Node.ELEMENT_NODE) {
        final String? hrefLink = child.attributes["href"];
        rtItems.add(_RichTextItem(text, link: hrefLink));
      }

      child.remove();
    }
    return rtItems;
  }

  @override
  Widget build(BuildContext context) {
    final List<_RichTextItem> richTexts = _parseRichDescription();

    return RichText(
      text: TextSpan(
        children:
            richTexts.map((rti) => _richTextToWidget(context, rti)).toList(),
      ),
    );
  }
}
