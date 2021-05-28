import 'package:flutter/material.dart';
import 'package:Golo/localization/Localized.dart';
import 'package:Golo/localization/LocalizedKey.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/blocs/navigation/NavigationBloc.dart';
import 'package:Golo/src/entity/City.dart';
import 'package:Golo/src/views/home/controls/CityCell.dart';

class Cities extends StatefulWidget {
  final List<City> cities;
  Cities({this.cities});
  @override
  _CitiesState createState() {
    return _CitiesState();
  }
}

class _CitiesState extends State<Cities> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 40, left: 25, right: 25, bottom: 10),
          child: Column(
            children: <Widget>[
              Text(
                  Localized.of(context).trans(LocalizedKey.allCities) ?? "",
                  style: TextStyle(
                      fontFamily: GoloFont,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      color: GoloColors.secondary1,
                      letterSpacing: 0),
                    
              ),
              Flexible(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: _buildCityGridView()
                ),
              )
            ],
          )),
    );
  }

  // ### City list
  Widget _buildCityGridView() => new GridView.count(
        padding: EdgeInsets.only(top: 5, bottom: 5),
        crossAxisCount: 2,
        childAspectRatio: 0.715,
        children: List.generate(widget.cities.length, (index) {
            return _buildCityCell(index);
        })
      );

  Widget _buildCityCell(int imageIndex) => Container(
          child: Container(
        margin: EdgeInsets.only(right: 8, bottom: 8),
        height: 350,
        child: GestureDetector(
        child: CityCell(city: widget.cities[imageIndex]),
        onTap: () {
          HomeNav(context).openCity(widget.cities[imageIndex]);
        },
      )
      ));
}
