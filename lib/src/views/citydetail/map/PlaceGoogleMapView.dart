import 'dart:async';
import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/src/views/citydetail/map/MyMapStyle.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Golo/modules/extension/Extension+String.dart';

class GoogleMapViewPlace extends StatefulWidget {
  final Place place;
  final bool isFullScreen;
  final double zoom;

  GoogleMapViewPlace({this.place, this.isFullScreen, this.zoom});
  @override
  _GoogleMapView createState() {
    return _GoogleMapView();
  }
}

class _GoogleMapView extends State<GoogleMapViewPlace> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set<Marker>();
  @override
  void initState() {
    super.initState();
    getMarkers(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildMap();
  }

  Widget _buildMap() {
    return Stack(children: [
      GoogleMap(
        padding: EdgeInsets.all(0),
        initialCameraPosition:
            CameraPosition(target: widget.place.location.getLatLng(), zoom: 14),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          controller.setMapStyle(MyMapStyle.normalMap);
          final cameraPosition = CameraPosition(
              target: widget.place.location.getLatLng(), zoom: widget.zoom);
          controller.moveCamera(CameraUpdate.newCameraPosition(cameraPosition));
          setState(() {});
        },
        myLocationButtonEnabled: false,
        markers: markers,
      ),
      // Header
      Visibility(
        visible: widget.isFullScreen,
        child: Container(
          height: 105,
          alignment: Alignment.centerLeft,
          child: SafeArea(
              bottom: false,
              child: Row(children: [
                // Back button
                Container(
                  margin: EdgeInsets.only(left: 25),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 2,
                            offset: Offset(0, 1),
                            color: Color.fromRGBO(0, 0, 0, 0.2))
                      ],
                      color: Colors.white),
                  height: 40,
                  width: 90,
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Icon(DenLineIcons.angle_left,
                              size: 15, color: GoloColors.secondary2),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 20, left: 10),
                          child: Text(
                            "Back",
                            style: TextStyle(
                                fontFamily: GoloFont,
                                fontSize: 16,
                                color: GoloColors.secondary1),
                          ),
                        )
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                // Show button
                // Container(
                //   margin: EdgeInsets.only(left: 15),
                //   height: 40,
                //   width: 113,
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(20),
                //       boxShadow: [
                //         BoxShadow(
                //             blurRadius: 2,
                //             offset: Offset(0, 1),
                //             color: Color.fromRGBO(0, 0, 0, 0.2))
                //       ],
                //       color: Colors.white),
                //   child: CupertinoButton(
                //       padding: EdgeInsets.all(0),
                //       child: Row(
                //         children: <Widget>[
                //           Padding(
                //             padding: EdgeInsets.only(left: 20),
                //             child: Text(
                //               "Show all",
                //               style: TextStyle(
                //                   fontFamily: GoloFont,
                //                   fontSize: 16,
                //                   color: GoloColors.primary),
                //             ),
                //           ),
                //           Padding(
                //               padding: EdgeInsets.only(right: 11, left: 7),
                //               child: Icon(
                //                 DenLineIcons.angle_down,
                //                 color: GoloColors.secondary2,
                //                 size: 12,
                //               ))
                //         ],
                //       ),
                //       onPressed: () {}),
                // )
              ])),
        ),
      ),
    ]);
  }

  void getMarkers(BuildContext context) {
    this.markers.clear();
      var place = widget.place;
      String imageString;
      switch (place.categories.first) {
        case 18:
          imageString = 'assets/iconGolo/icon-see@3x.png';
          break;
        case 19:
          imageString = 'assets/iconGolo/icon-eat-drink@3x.png';
          break;
        case 20:
          imageString = 'assets/iconGolo/icon-stay@3x.png';
          break;
        case 21:
          imageString = 'assets/iconGolo/icon-shop@3x.png';
          break;
        default:
          imageString = 'assets/iconGolo/icon-shop@3x.png';
      }

      BitmapDescriptor.fromAssetImage(
              ImageConfiguration(devicePixelRatio: 0.75), imageString)
          .then((value) {
        final marker = Marker(
          position: place.location.getLatLng(),
          markerId: MarkerId("${place.id}"),
          icon: value,
          onTap: () {
            setState(() {                            
            });
          },
        );
        markers.add(marker);
      });
    
  }
}
