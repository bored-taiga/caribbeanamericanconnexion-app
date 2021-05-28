import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/controls/helpers/MyUrlHelper.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Place.dart';

class PlaceDetailContact extends StatefulWidget {
  final Place place;

  PlaceDetailContact({Key key, this.place}) : super(key: key);
  @override
  _PlaceDetailContactState createState() => _PlaceDetailContactState();
}

class _PlaceDetailContactState extends State<PlaceDetailContact> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(0),
                height: calculateHeight(widget.place.address),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(DenLineIcons.map_marked_alt,
                          color: GoloColors.secondary2, size: 20),
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 20),
                            padding: EdgeInsets.all(0),
                            child: Text(widget.place.address ?? "-",
                                style: TextStyle(
                                    fontFamily: GoloFont,
                                    fontSize: 17,
                                    color: GoloColors.secondary2),
                                overflow: TextOverflow.ellipsis)),
                      )
                    ],
                  ),
                  visible: isVisible(widget.place.address),
                )),
            Container(
                height: calculateHeight(widget.place.email),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: GestureDetector(
                    onTap: () {
                      MyUrlHelper.mailTo(widget.place.email);
                    },
                    child: Row(
                    children: <Widget>[
                      Icon(DenLineIcons.envelope,
                          color: GoloColors.secondary2, size: 20),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: SelectableText(
                            widget.place.email ?? "-",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 17,
                                  color: GoloColors.secondary2)))
                    ],
                  )
                  ),
                  visible: isVisible(widget.place.email),
              )
            ),
            Container(
                height: calculateHeight(widget.place.phone),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: GestureDetector(
                    onTap: () {
                      MyUrlHelper.callTo(widget.place.phone);
                    },
                    child: Row(
                    children: <Widget>[
                      Icon(DenLineIcons.phone,
                          color: GoloColors.secondary2, size: 20),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.place.phone ?? "-",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 17,
                                  color: GoloColors.secondary2)))
                    ],
                  ),
                  ),
                  visible: isVisible(widget.place.phone),
                )),
            Container(
                height: calculateHeight(widget.place.website),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: GestureDetector(
                    onTap: () {
                      MyUrlHelper.open(widget.place.website);
                    },
                    child: Row(
                    children: <Widget>[
                      Icon(DenLineIcons.globe_africa,
                          color: GoloColors.secondary2, size: 20),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.place.website ?? "-",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 17,
                                  color: GoloColors.secondary2)))
                    ],
                  ),
                  ),
                  visible: isVisible(widget.place.website),
                )),
            Container(
                height: calculateHeight(widget.place.facebook),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: GestureDetector(
                    onTap: () {
                      MyUrlHelper.open(widget.place.facebook);
                    },
                    child: Row(
                    children: <Widget>[
                      Icon(DenLineIcons.facebook_square,
                          color: GoloColors.secondary2, size: 20),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.place.facebook ?? "-",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 17,
                                  color: GoloColors.secondary2)))
                    ],
                  ),
                  ),
                  visible: isVisible(widget.place.facebook),
                )),
            Container(
                height: calculateHeight(widget.place.instagram),
                alignment: Alignment.centerLeft,
                child: Visibility(
                  child: GestureDetector(
                    onTap: () {
                      MyUrlHelper.open(widget.place.instagram);
                    },
                    child: Row(
                    children: <Widget>[
                      Icon(DenLineIcons.instagram,
                          color: GoloColors.secondary2, size: 20),
                      Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(widget.place.instagram ?? "-",
                              style: TextStyle(
                                  fontFamily: GoloFont,
                                  fontSize: 17,
                                  color: GoloColors.secondary2)))
                    ],
                  ),
                  ),
                  visible: isVisible(widget.place.instagram),
                )),
          ],
        ),
      ),
    );
  }

  double calculateHeight(String text) {
    return isVisible(text) ? 40 : 0;
  }

  bool isVisible(String text) {
    return text != null && text.isNotEmpty;
  }
}
