

import 'package:Golo/src/entity/Place.dart';

class CityDetailModel{

  List<Place> places;
  Map<int, List<Place>> _groupedPlaces;
  Map<int, List<Place>> get groupedPlaces => _groupedPlaces;

}