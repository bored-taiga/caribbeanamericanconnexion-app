import 'package:html/parser.dart';

import 'Base.dart';

class PlaceCategory extends Base{
  int count;
  String description;
  String name;
  int parentId;

  PlaceCategory(Map<String, dynamic> json) : super(json){
    count = json["count"];
    description = json["description"];
    name = parse(json["name"] ?? "").documentElement.text;
    parentId = json["parent"];
    count = json["parent"];
  }

  factory PlaceCategory.fromJson(Map<String, dynamic> json) {
    return PlaceCategory(json);
  }
}