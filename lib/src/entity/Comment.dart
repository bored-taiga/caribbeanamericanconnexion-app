
import 'package:html/parser.dart';
import 'Base.dart';

class Comment extends Base{

  int post;
  String authorName;
  String dateGmt;
  String content; // content>rendered
  String link;

  Comment(Map<String, dynamic> json) : super(json) {
    post = json["post"];
    authorName = json["author_name"];
    dateGmt = json["date_gmt"];
    link = json["link"];
    content = json["content"]["rendered"];

    // Convert
    content = parse(content).documentElement.text;
  }
}