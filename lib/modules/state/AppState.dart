

import 'package:Golo/src/entity/City.dart';
import 'package:Golo/src/entity/PlaceAmenity.dart';
import 'package:Golo/src/entity/PlaceCategory.dart';
import 'package:Golo/src/entity/PlaceType.dart';
import 'package:Golo/src/entity/Post.dart';

class AppState {
  static final AppState _instance = AppState._internal();

  factory AppState() {
    return _instance;
  }

  // Cities
  List<City> cities = [];
  // Categories | Amenities
  List<PlaceCategory> categories = [];
  List<PlaceAmenity> amenities = [];
  // Posts
  List<Post> posts = [];
  // Place of current city
  // City currentCity;
  // List<Place> places = [];
  List<PlaceType> placeTypes = [];

  AppState._internal() {
    
  }

  // void clearCurrentCity() {
    // currentCity = null;
    // places.clear();
  // }

}