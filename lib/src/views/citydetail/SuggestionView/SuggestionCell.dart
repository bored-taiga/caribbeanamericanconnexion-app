import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/controls/images/MyImageHelper.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/entity/Place.dart';

class SuggestionCell extends StatefulWidget {
  final Place place;

  SuggestionCell({Key key, this.place}) : super(key: key);
  @override
  _SuggestionCell createState() {
    return _SuggestionCell();
  }
}

class _SuggestionCell extends State<SuggestionCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            //1. Image
            MyImage.from(widget.place.featuredMediaUrl,
                borderRadius: new BorderRadius.all(Radius.circular(15)),
                color: GoloColors.secondary3),
            Container(
              decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                  gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(200)],
                      stops: [0.4, 1.0])),
            ),
            //3. Lable, title
            Container(
                child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Container(
                  margin: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              getPlaceTypes(widget.place.types) ?? "",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.place.title ?? "",
                                style: TextStyle(
                                    fontFamily: GoloFont,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                maxLines: 2,
                              )),
                        ],
                      ),
                      Container(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.place.rate ?? "",
                                      style: TextStyle(
                                        fontFamily: GoloFont,
                                        color: GoloColors.primary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.place.hasRate,
                                    child: Icon(DenLineIcons.star,
                                        color: GoloColors.primary, size: 11)
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.only(left: 5),
                                    child: Text(
                                        widget.place.reviewCount <= 0 ? "" : "(${widget.place.reviewCount})", // review count
                                        style: TextStyle(
                                          fontFamily: GoloFont,
                                          color: GoloColors.primary,
                                          fontSize: 15,
                                        )),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(widget.place.priceRange ?? r"$",
                                    style: TextStyle(
                                      fontFamily: GoloFont,
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            )),
            //2. Button
            Align(
              alignment: Alignment.topRight,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20, right: 20),
                decoration:
                    BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                height: 32,
                width: 32,
                child: CupertinoButton(
                  padding:
                      EdgeInsets.only(left: 0, top: 0, bottom: 0, right: 6),
                  onPressed: () {},
                  child: Icon(DenLineIcons.bookmark,
                      size: 20, color: GoloColors.secondary2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getPlaceTypes(List<int> types) {
    return AppState()
        .placeTypes
        .where((placeType) => types.contains(placeType.id))
        .map((placeType) => placeType.name)
        .join(", ");
  }
}
