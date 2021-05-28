

import 'Base.dart';
import 'Place.dart';

class City extends Base{
  int count;
  String name;
  String description;
  // Get from other request
  String featuredImamge; // media?slug=$slug
  String country;
  String intro;
  String location;
  String address;
  String visitTime;
  String currency;
  String language;

  City(Map<String, dynamic> json) : super(json){
    count = json["count"];
    name = json["name"];
    description = json["description"];
    country = json["place_city_country"];
    intro = json["place_city_banner_intro"];
    location = json["place_city_address"]["location"];
    address =  json["place_city_address"]["address"];
    featuredImamge = json["place_city_featured_image"]["url"];
    visitTime = json["place_city_visit_time"];
    currency = json["place_city_currency"];
    language = json["place_city_language"];
  }
  
  factory City.fromJson(Map<String, dynamic> json) {
    return City(json);
  }

}