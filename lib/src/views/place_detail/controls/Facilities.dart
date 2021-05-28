import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/PlaceAmenity.dart';

class FacilitiesView extends StatefulWidget {
  final List<PlaceAmenity> amenities;
  FacilitiesView({Key key, this.amenities}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _FacilitiesViewState();
  }
}

class _FacilitiesViewState extends State<FacilitiesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
          itemCount: widget.amenities.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            margin: EdgeInsets.only(left: index == 0 ? 25 : 0, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: SvgPicture.network(
                    widget.amenities[index].iconUrl,
                    fit: BoxFit.contain,
                    width: 25,
                    height: 25,
                  placeholderBuilder: (BuildContext context) => Container(
                      padding: const EdgeInsets.all(30.0),
                      child: const CircularProgressIndicator()),
                  ),
                ),
                Container(
                  height: 40,
                  child: Text(widget.amenities[index].name ?? "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 15,
                        color: GoloColors.secondary2),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
