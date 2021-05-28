import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/modules/controls/images/MyImageHelper.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/entity/Post.dart';

class ArticleCell extends StatefulWidget {

  final Post post;

  ArticleCell({Key key, this.post}): super(key: key);

  @override
  _ArticleCellState createState() {
    return _ArticleCellState();
  }
}

class _ArticleCellState extends State<ArticleCell> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              borderRadius: new BorderRadius.all(Radius.circular(30)),
            ),
            child: Column(
              children: <Widget>[
                
                Container(
                  child: MyImage.from(
                    widget.post.featuredMediaUrl, 
                    borderRadius: new BorderRadius.all(Radius.circular(8)),
                    color: GoloColors.secondary3
                  ),
                  height: 200,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 15),
                  child: Text(
                    "TIP & TRICK",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 16,
                        color: GoloColors.secondary2,
                        decoration: TextDecoration.underline,
                        decorationColor: GoloColors.primary),
                    textAlign: TextAlign.left,
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Container(
                  child: Text(
                    widget.post != null ? (widget.post.title ?? "") : "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontSize: 17,
                        color: GoloColors.secondary1,
                        fontWeight: FontWeight.w500),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )));
  }
}
