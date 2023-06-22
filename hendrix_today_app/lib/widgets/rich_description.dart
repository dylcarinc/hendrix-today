import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:html/parser.dart'
    show parse;
import 'package:html/dom.dart'
    show Document, Node;
import 'package:url_launcher/url_launcher.dart';

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

  static TextStyle _getPlainTextStyle(BuildContext context) => TextStyle(
    color: Colors.black,
    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
  );
  static TextStyle _getLinkTextStyle(BuildContext context) => TextStyle(
    color: const Color.fromARGB(255, 202, 81, 39),
    fontFamily: DefaultTextStyle.of(context).style.fontFamily,
    decoration: TextDecoration.underline,
  );

  /// Attempts to launch the given URL string in an external browser. Fails if 
  /// the given URL is null, cannot be parsed to a URI, or cannot be handled by 
  /// the device.
  static void _tryLaunchUrl(String? url) async {
    if (url == null) return;
    final Uri? uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await canLaunchUrl(uri)) return;
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  /// Converts a [_RichTextItem] to a [TextSpan]. If the item has a link, the 
  /// [TextSpan] will have a [TapGestureRecognizer] that will open the 
  /// associated link on tap.
  TextSpan _richTextToWidget(BuildContext context, _RichTextItem item) {
    return !item.isLink
      ? TextSpan(
        text: item.text,
        style: _getPlainTextStyle(context),
      )
      : TextSpan(
        text: item.text,
        style: _getLinkTextStyle(context),
        // https://stackoverflow.com/a/50011168 for TextSpan onTap
        recognizer: TapGestureRecognizer()
          ..onTap = () => _tryLaunchUrl(item.link),
      );
  }

  /// Parses this [RichDescription]'s raw text into a [List] of 
  /// [_RichTextItem]s by parsing it as HTML into a DOM document and iterating 
  /// over it, only using a custom subset of nodes (in this case, only text 
  /// nodes and `<a>` elements with `href` attributes).
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
        children: richTexts
          .map((rti) => _richTextToWidget(context, rti))
          .toList(),
      ),
    );
  }
}
