import 'dart:math';

import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/localization/Localized.dart';
import 'package:Golo/localization/LocalizedKey.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/views/citydetail/Filter/GroupOption/GroupOption.dart';

class FilterCityDetail extends StatefulWidget {
  final Function(List<String> prices, List<String> types, List<String> amenities) onFilter; 
  final List<String >selectedOptionPrices;
  final List<String >selectedOptionTypes;
  final List<String >selectedOptionAmenities;
  FilterCityDetail({this.onFilter, this.selectedOptionPrices, this.selectedOptionAmenities, this.selectedOptionTypes });


  @override
  _FilterCityDetail createState() {
    return _FilterCityDetail();
  }
}

class _FilterCityDetail extends State<FilterCityDetail> {
  Color _headerBackgroundColor = Colors.white;
  Color _titleColor = GoloColors.secondary1;
  ScrollController _scrollController;
  @override
  void initState() {
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
    super.initState();
    filterSelectedOption(widget.selectedOptionPrices, widget.selectedOptionTypes, widget.selectedOptionAmenities);
  }

  List<Option> priceOptions = [
    Option(title: "Free", isSelected: false, key: "free"),
    Option(title: r"Low: $", isSelected: false, key: r"$"),
    Option(title: r"Medium: $$", isSelected: false,key: r"$$"),
    Option(title: r"High: $$$", isSelected: false, key: r"$$$"),
  ];
  List<Option> typesOptions = AppState().placeTypes.map((type) => Option(title: type.name, isSelected: false, key: "${type.id}")).toList();
  List<Option> amenitiesOptions = AppState().amenities.map((amenity) => Option(title: amenity.name, isSelected: false, key: "${amenity.id}")).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Stack(
          alignment: Alignment.topLeft,
          children: <Widget>[
            Column(
              children: <Widget>[
                //List filter
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(left: 25, right: 25),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 61),
                          height: 1,
                          color: Color(0xffeeeeee)),
                      GroupOption(
                        title: "Price",
                        options: priceOptions,
                      ),
                      GroupOption(
                        title: "Types",
                        options: typesOptions,
                      ),GroupOption(
                        title: "Amenities",
                        options: amenitiesOptions,
                      )
                    ],
                  ),
                )),
                //Button apply filter
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(bottom: 15),
                  child: Container(
                    height: 45,
                    width: 140,
                    decoration: BoxDecoration(
                        color: GoloColors.primary,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: FlatButton(
                      onPressed: () {
                        applyFilter();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Apply filter",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _buildHeader()
          ],
        ));
  }

  //Header bar
  Widget _buildHeader() {
    return Container(
        height: 105,
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
                      size: 24, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Text(
                  Localized.of(context).trans(LocalizedKey.filter),
                  style: TextStyle(
                      fontFamily: GoloFont,
                      fontSize: 24,
                      color: _titleColor,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                  margin: EdgeInsets.only(right: 25),
                  child: CupertinoButton(
                    padding: EdgeInsets.only(right: 0),
                    child: Text(
                      "Clear",
                      style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: GoloColors.primary,
                      ),
                    ),
                    onPressed: () {
                      actionClear();
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void applyFilter(){
    var prices = priceOptions.where((option) => option.isSelected).toList().map((option) => option.key).toList();
    var types = typesOptions.where((option) => option.isSelected).toList().map((option) => option.key).toList();
    var amenities = amenitiesOptions.where((option) => option.isSelected).toList().map((option) => option.key).toList();
    this.widget.onFilter(prices,types,amenities);
  } 

  void filterSelectedOption( List<String>selectedPrice, List<String> selectedType, List<String> selectedAmenity){
    priceOptions.forEach((option){
      option.isSelected = selectedPrice.contains(option.key);
    });

    typesOptions.forEach((option){
      option.isSelected = selectedType.contains(option.key);
    });
    
    amenitiesOptions.forEach((option){
      option.isSelected = selectedAmenity.contains(option.key);
    });
  }
  void actionClear(){
   filterSelectedOption([], [], []); 
   applyFilter();
  }
}
