import 'dart:math';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Place.dart';

class PlaceDetailOpenTime extends StatefulWidget {

  final Place place;
  final bool showFull;

  PlaceDetailOpenTime({Key key, this.place, this.showFull}) : super(key: key);

  @override
  _PlaceDetailOpenTimeState createState() => _PlaceDetailOpenTimeState();
}

class _PlaceDetailOpenTimeState extends State<PlaceDetailOpenTime> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: _buildTimeRow()
      ),
    );
  }

  Widget _buildTimeRow() {
    var keys = widget.place.openingTime.keys.toList();
    var length = widget.showFull ? keys.length: min(keys.length, 2);
    return Container(
      child: Column(
          children: List.generate(length, (int index) => Container(
              height: 40,
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Text(
                      keys[index],
                      style: TextStyle(
                          fontFamily: GoloFont,
                          fontSize: 17,
                          color: GoloColors.secondary1,
                          fontWeight: FontWeight.w500)),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                          widget.place.openingTime[keys[index]] ?? "",
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 17,
                              color: GoloColors.secondary2)))
                ],
              ),
            ))
        )
    );
  }
}
