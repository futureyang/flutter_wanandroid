import 'package:html/parser.dart';

extension HtmlExtension on String {
  String htmlToSpanned() {
    var document = parse(this);
    String parsedString = parse(document.body.text).documentElement.text;
    return parsedString;
  }
}
