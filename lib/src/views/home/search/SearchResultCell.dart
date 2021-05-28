import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Place.dart';

class SearchResultCell extends StatefulWidget {
  // Callback events
  final void Function(int) onPressedCity; // string: city name
  final void Function(Place) onPressedPlace;
  // Properties
  final Place place;

  SearchResultCell({Key key, this.place, this.onPressedCity, this.onPressedPlace}) : super(key: key);

  @override
  _SearchResultCellState createState() => _SearchResultCellState();
}

class _SearchResultCellState extends State<SearchResultCell> {

  var index;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: <Widget>[
           Expanded(
             flex: 2,
             child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           CupertinoButton(
             padding: EdgeInsets.all(0),
             onPressed: () {
               widget.onPressedPlace(widget.place);
             },
             child: Text.rich(

             TextSpan(
               children: [
                  TextSpan(
                    text: "${widget.place.title}",
                    style: TextStyle(
                      fontFamily: GoloFont,
                      fontSize: 15,
                      color: GoloColors.secondary2
                    )
                  ),
               ]
             )
           ),
           ),
           CupertinoButton(
             padding: EdgeInsets.all(0),
             onPressed: () {
               widget.onPressedCity(widget.place.cities.first);
             },
             child: Text(
                    "${widget.place.cityName}", 
                    style: TextStyle(
                      fontFamily: GoloFont,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: GoloColors.secondary1
                    )
                  ),
           )
         ],
       ),
           ),
           Container(
             height: 1,
             color: GoloColors.secondary3,
           )
         ],
       ),
    );
  }

  
}