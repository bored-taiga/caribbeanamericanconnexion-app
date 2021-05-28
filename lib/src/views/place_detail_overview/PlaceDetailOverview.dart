import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/City.dart';

class PlaceDetailOverview extends StatelessWidget {
  final String content;
  final City city;

  const PlaceDetailOverview({Key key, this.content, this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                height: 60,
                child: Stack(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        city != null ? "City Infomations" : "Overview",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: GoloColors.secondary1),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 5),
                      child: CupertinoButton(
                        child: Icon(DenLineIcons.angle_left,
                            size: 24, color: GoloColors.secondary1),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(20),
                    child: city != null ? _buildCityInfo() : _buildContent()),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      child: Text(
        content ?? "",
        style: TextStyle(
            fontFamily: GoloFont,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: GoloColors.secondary2),
      )
    );
  }

  Widget _buildCityInfo() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            city.description,
            style: TextStyle(
                fontFamily: GoloFont,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                color: GoloColors.secondary2),
          ),
          Visibility(
              visible: city.currency != null && city.currency.isNotEmpty,
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                  Text(
                    "Currency".toUpperCase(),
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: GoloColors.secondary1),
                  ),
                  Text(
                    city.currency ?? "-",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: GoloColors.secondary2),
                  ),
                ]),
              )),
          Visibility(
              visible: city.language != null && city.language.isNotEmpty,
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "language".toUpperCase(),
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: GoloColors.secondary1),
                      ),
                      Text(
                        city.language ?? "-",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: GoloColors.secondary2),
                      ),
                    ],
                  ))),
          Visibility(
              visible: city.visitTime != null && city.visitTime.isNotEmpty,
              child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Best time to visit".toUpperCase(),
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                            color: GoloColors.secondary1),
                      ),
                      Text(
                        city.visitTime ?? "-",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: GoloColors.secondary2),
                      ),
                    ],
                  ))),
        ]);
  }
}
