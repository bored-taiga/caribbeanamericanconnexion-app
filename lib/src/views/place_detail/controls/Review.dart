import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Comment.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/src/views/controls/RateStarView.dart';

class PlaceDetailReview extends StatefulWidget {
  final Place place;

  @override
  _PlaceDetailReviewState createState() => _PlaceDetailReviewState();

  PlaceDetailReview({Key key, this.place}) : super(key: key);
}

class _PlaceDetailReviewState extends State<PlaceDetailReview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Review (${widget.place.reviewCount})",
                  style: TextStyle(
                      fontFamily: GoloFont,
                      fontSize: 21,
                      color: GoloColors.secondary1,
                      fontWeight: FontWeight.w500)),
              Visibility(
                visible: widget.place.hasRate,
                child: Container(
                  margin: EdgeInsets.only(left: 12, right: 8),
                  child: Text(widget.place.rate ?? "",
                      style: TextStyle(
                          fontFamily: GoloFont,
                          fontSize: 21,
                          color: GoloColors.primary,
                          fontWeight: FontWeight.w500)),
                ),
              ),
              Visibility(
                  visible: widget.place.hasRate,
                  child: Icon(DenLineIcons.star,
                      color: GoloColors.primary, size: 14))
            ],
          ),
          Container(
            child: Column(
                children: widget.place.comments.map((Comment comment) {
              return Container(
                margin: EdgeInsets.only(top: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/photos/paris.jpg"),
                                    fit: BoxFit.fill),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                                color: Colors.transparent),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "${comment.authorName}",
                                      style: TextStyle(
                                          fontFamily: GoloFont,
                                          fontSize: 17,
                                          color: GoloColors.secondary1,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: RateStarView(),
                                    )
                                  ],
                                ),
                                Text(
                                  "${comment.dateGmt}",
                                  style: TextStyle(
                                    fontFamily: GoloFont,
                                    fontSize: 14,
                                    color: GoloColors.secondary2,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Text(
                        "${comment.content}",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            fontSize: 17,
                            color: GoloColors.secondary1),
                      ),
                    )
                  ],
                ),
              );
            }).toList()),
          )
        ],
      ),
    );
  }
}
