import 'dart:ffi';
import 'dart:math';

import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/src/entity/PlaceAmenity.dart';
import 'package:Golo/src/views/citydetail/map/PlaceGoogleMapView.dart';
import 'package:Golo/src/views/place_detail/controls/Contact.dart';
import 'package:Golo/src/views/place_detail/controls/Header.dart';
import 'package:Golo/src/views/place_detail/controls/Review.dart';
import 'package:Golo/src/views/place_detail_overview/PlaceDetailOverview.dart';

import 'controls/Facilities.dart';
import 'controls/OpenTime.dart';

class PlaceDetail extends StatefulWidget {
  final Place place;

  PlaceDetail({Key key, this.place}) : super(key: key);

  @override
  _PlaceDetailState createState() {
    return _PlaceDetailState();
  }
}

class _PlaceDetailState extends State<PlaceDetail> {
  ScrollController _scrollController;
  Color _headerBackgroundColor = GoloColors.clear;
  Color _titleColor = GoloColors.clear;
  List<PlaceAmenity> amenities;
  // Show full opening time
  bool showFullOpeningTime = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        var offset = _scrollController.offset;
        // Header background color
        var alpha = offset > 0 ? min(255, offset.toInt()) : 0;
        _headerBackgroundColor = GoloColors.primary.withAlpha(alpha);
        // Title color
        _titleColor = Colors.white.withAlpha(offset > 255 ? 255 : 0);
        // State
        setState(() {});
      });
    // Get list amenity for place
    amenities = AppState()
        .amenities
        .where((tmp) => widget.place.amenities.contains(tmp.id))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          controller: _scrollController,
                          padding: EdgeInsets.all(0),
                          children: <Widget>[
                            Container(
                                height: 250,
                                child: PlaceDetailHeader(
                                  place: widget.place,
                                )),
                            Container(
                              height: amenities.length > 0 ? 95 : 0,
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                      child: amenities.length > 0
                                          ? FacilitiesView(
                                              amenities: amenities,
                                            )
                                          : Container()),
                                  Container(
                                    height: 1,
                                    color: GoloColors.secondary3.withAlpha(180),
                                  )
                                ],
                              ),
                            ),
                            // Overview
                            Container(
                              margin: EdgeInsets.only(
                                  left: 25, right: 25, top: 20, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Overview",
                                    style: TextStyle(
                                        fontFamily: GoloFont,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: GoloColors.secondary1),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 10, bottom: 0),
                                    child: Text(
                                      widget.place != null
                                          ? (widget.place.excerpt ?? "")
                                          : "",
                                      style: TextStyle(
                                          fontFamily: GoloFont,
                                          fontSize: 17,
                                          color: GoloColors.secondary2),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  CupertinoButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      openOverview(context);
                                    },
                                    child: Text("Show more",
                                        style: TextStyle(
                                            fontFamily: GoloFont,
                                            fontSize: 16,
                                            color: GoloColors.primary,
                                            fontWeight: FontWeight.w500)),
                                  )
                                ],
                              ),
                            ),
                            // MAP VIEW
                            Container(
                              padding: EdgeInsets.all(0),
                              height: 220,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 30,
                                    margin: EdgeInsets.only(left: 25),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Maps View",
                                      style: TextStyle(
                                          fontFamily: GoloFont,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          color: GoloColors.secondary1),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: (){
                                        _openMap();
                                      },
                                      child: Container(
                                          margin: EdgeInsets.only(top: 10),
                                          child: AbsorbPointer(
                                            child: GoogleMapViewPlace(
                                              isFullScreen: false,
                                              zoom: 14,
                                              place: widget.place,
                                            ),
                                            absorbing: true,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // Location & contacts
                            Container(
                              margin:
                                  EdgeInsets.only(top: 25, left: 25, right: 25),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: Text("Location & Contact",
                                        style: TextStyle(
                                            fontFamily: GoloFont,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: GoloColors.secondary1)),
                                  ),
                                  PlaceDetailContact(
                                    place: widget.place,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15),
                                    color: GoloColors.secondary3.withAlpha(180),
                                    height: 1,
                                  )
                                ],
                              ),
                            ),
                            // OPEN TIME
                            Visibility(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 25, left: 25, right: 25),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.topLeft,
                                      child: Text("Opening Time",
                                          style: TextStyle(
                                              fontFamily: GoloFont,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: GoloColors.secondary1)),
                                    ),
                                    PlaceDetailOpenTime(
                                      place: widget.place,
                                      showFull: showFullOpeningTime,
                                    ),
                                    Visibility(
                                      child: CupertinoButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          setState(() {
                                            showFullOpeningTime =
                                                !showFullOpeningTime;
                                          });
                                        },
                                        child: Text(
                                            showFullOpeningTime
                                                ? "Show less"
                                                : "Show more",
                                            style: TextStyle(
                                                fontFamily: GoloFont,
                                                fontSize: 16,
                                                color: GoloColors.primary,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                      visible:
                                          widget.place.openingTime.length > 2,
                                    )
                                  ],
                                ),
                              ),
                              visible: widget.place.openingTime.length > 0,
                            ),
                            // REVIEW
                            Container(
                              margin: EdgeInsets.only(top: 25),
                              color: GoloColors.secondary1.withAlpha(15),
                              child: Container(
                                margin: EdgeInsets.all(25),
                                child: PlaceDetailReview(
                                  place: widget.place,
                                ),
                              ),
                            ),
                            Container(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                      // Container(
                      //   height: 80,
                      //   alignment: Alignment.center,
                      //   padding: EdgeInsets.only(bottom: 15),
                      //   child: Container(
                      //     height: 45,
                      //     width: 300,
                      //     decoration: BoxDecoration(
                      //         color: GoloColors.primary,
                      //         borderRadius: BorderRadius.all(Radius.circular(25))),
                      //     child: FlatButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Text(
                      //         "Book",
                      //         style: TextStyle(
                      //             fontFamily: GoloFont,
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.w500,
                      //             color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
                _buildHeader()
              ],
            )));
  }

  // ### HEADER
  Widget _buildHeader() {
    return Container(
        height: 85,
        color: _headerBackgroundColor,
        child: SafeArea(
            bottom: false,
            child: Container(
              color: _headerBackgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CupertinoButton(
                    child: Icon(DenLineIcons.angle_left,
                        size: 22, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Text(
                    widget.place != null ? (widget.place.title ?? "") : "",
                    style: TextStyle(
                        fontFamily: GoloFont, fontSize: 24, color: _titleColor),
                  ),
                  CupertinoButton(
                    child: Icon(DenLineIcons.bookmark,
                        size: 24, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            )));
  }

  // ### ACTIONS
  void openOverview(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 222),
        pageBuilder: (BuildContext context, _, __) {
          return PlaceDetailOverview(
            content: widget.place.content,
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            child: child,
            position:
                animation.drive(Tween(begin: Offset(0.5, 0), end: Offset.zero)),
          );
        },
        fullscreenDialog: true));
  }

  void _openMap() {
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 222),
        pageBuilder: (BuildContext context, _, __) {
          return Container(
            child: GoogleMapViewPlace(
              place: widget.place,
              isFullScreen: true,
              zoom: 14,
            ),
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            child: child,
            position:
                animation.drive(Tween(begin: Offset(0.5, 0), end: Offset.zero)),
          );
        },
        fullscreenDialog: true));
  }

}
