import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/controls/images/MyImageHelper.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/City.dart';

class CityCell extends StatefulWidget {
  final City city;

  CityCell({Key key, this.city}): super(key: key);
  
  @override
  _CityCellState createState() {
    
    return _CityCellState();
  }
}

class _CityCellState extends State<CityCell> {
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
          MyImage.from(
                    widget.city.featuredImamge, 
                    borderRadius: new BorderRadius.all(Radius.circular(15)),
                  ),
          Container(
            height: 350.0,
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(15)),
                color: Colors.white,
                gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withAlpha(200)],
                    stops: [0.4, 1.0])),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15, top: 20),
                  child: Text(
                          widget.city != null ? (widget.city.country ?? "") : "",
                          style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, bottom: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(widget.city.name ?? "",
                            style: TextStyle(
                                fontFamily: GoloFont,
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.w500)),
                        Text(widget.city != null ? "${widget.city.count ?? 0} places" : "0 places",
                            style: TextStyle(
                                fontFamily: GoloFont,
                                fontSize: 16,
                                color: Colors.white))
                      ]),
                )
              ],
            ),
          )
        ],
      ),
    ));
  }
}
