
import 'package:Golo/src/entity/Base.dart';
import 'package:html/parser.dart';

class Post extends Base {

  String title;
  String content;
  String link;
  String type;
  String excerpt;
  String featuredMedia; // feature image id
  String commentStatus;
  List<String> categories;
  String featuredMediaUrl;
  
  Post(Map<String, dynamic> json) : super(json) {
    title = parse(json["title"]["rendered"] ?? "").documentElement.text;
    content = parse(json["content"]["rendered"] ?? "").documentElement.text;
    excerpt = parse(json["excerpt"]["rendered"] ?? "").documentElement.text;
    link = json["link"];
    type = json["type"];
    featuredMedia = json["featured_media"].toString();
    commentStatus = json["comment_status"];
    // categories
    categories = [];
    List<dynamic> cats = json["categories"];
    cats.forEach((value) {
      categories.add(value.toString());
    });
    // featured_media_url
    featuredMediaUrl = json["featured_media_url"];
  }
  
}