
import 'package:google_maps_flutter/google_maps_flutter.dart';

extension GetLatLng on String {
  LatLng getLatLng (){
    var latAndLng = this.split(",").map((text) => double.tryParse(text)).toList();
    if (latAndLng.length == 2) {
      return LatLng(latAndLng[0], latAndLng[1]);
    }
    return null;
  }
}