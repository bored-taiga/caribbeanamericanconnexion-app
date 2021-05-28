import 'Base.dart';

class PlaceType extends Base{
    int count;
    String description;    
    String name;    
  PlaceType(Map<String, dynamic> json) : super(json) {
    count = json["count"];
    description = json["description"];
    name = json["name"];
  }
  factory PlaceType.fromJson(Map<String, dynamic> json) {
    return PlaceType(json);
  }
}