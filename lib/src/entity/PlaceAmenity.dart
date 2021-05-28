
import 'Base.dart';

class PlaceAmenity extends Base {
  String name;
  String iconUrl;


  PlaceAmenity(Map<String, dynamic> json) : super(json){
    name = json["name"];
    iconUrl = json["place_amenities_icon"]["url"];
  }
  

  factory PlaceAmenity.fromJson(Map<String, dynamic> json) {
    return PlaceAmenity(json);
  }
  
}