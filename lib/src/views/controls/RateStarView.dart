import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';

class RateStarView extends StatefulWidget {

  @override
  _RateStarViewState createState() => _RateStarViewState();
}

class _RateStarViewState extends State<RateStarView> {

  var rate = 4;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Row(
         children: List.generate(rate, (i) {
          return Container(
            margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
            child: Icon(DenLineIcons.star, color: GoloColors.primary, size: 12),
          );
         })
       ),
    );
  }
}