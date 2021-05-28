

import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/controls/images/MyImageHelper.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/entity/Place.dart';

class PlaceDetailHeader extends StatefulWidget {

  final Place place;

  PlaceDetailHeader({Key key, this.place}): super(key: key);

  @override
  _PlaceDetailHeaderState createState() {
    return _PlaceDetailHeaderState();
  }
}

class _PlaceDetailHeaderState extends State<PlaceDetailHeader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
            children: <Widget>[
              MyImage.from(
                    widget.place.featuredMediaUrl,
                    color: GoloColors.secondary3
                  ),
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: FractionalOffset.topCenter,
                          end: FractionalOffset.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(180)
                          ],
                          stops: [
                            0.4,
                            1.0
                          ]))),
              Container(
                child: Container(
                  margin: EdgeInsets.only(left: 25, bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(AppState().categories.firstWhere((tmp)=>tmp.id == widget.place.categories[0], orElse: ()=> null).name,
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 12,
                              color: Colors.white)),
                      Text(
                        widget.place != null ? (widget.place.title ?? "") : "",
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      Row(
                        children: <Widget>[
                          Text(
                              widget.place.rate ?? "",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 15,
                                  color: GoloColors.primary,
                                  fontWeight: FontWeight.w500)),
                          Visibility(
                            visible: widget.place.hasRate,
                            child: Icon(DenLineIcons.star,
                                color: GoloColors.primary, size: 12)
                          ),
                          Visibility(
                            visible: widget.place.reviewCount > 0,
                            child: Container(
                              margin: EdgeInsets.only(left: 6),
                              child: Text("(${widget.place.reviewCount} reviews)",
                                  style: TextStyle(
                                      fontFamily: GoloFont,
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                            )
                          ),
                          Visibility(child: Container(
                            margin: EdgeInsets.only(left: 6, right: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(3)),
                                color: Colors.white.withAlpha(120)),
                          ),
                          visible: widget.place.priceRange != null && widget.place.priceRange.isNotEmpty,
                          ),
                          Text(
                              widget.place.priceRange ?? "",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                          Container(
                            margin: EdgeInsets.only(left: 6, right: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                                borderRadius:
                                    new BorderRadius.all(Radius.circular(3)),
                                color: Colors.white.withAlpha(120)),
                          ),
                          Text("Restaurant",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500)),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
    );
  }
}