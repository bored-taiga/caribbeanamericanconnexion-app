import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Golo/localization/Localized.dart';
import 'package:Golo/localization/LocalizedKey.dart';
import 'package:Golo/modules/controls/helpers/MyUrlHelper.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/blocs/navigation/NavigationBloc.dart';
import 'package:Golo/src/entity/City.dart';
import 'package:Golo/src/views/home/controls/ArticleCell.dart';
import 'package:Golo/src/views/home/controls/CityCell.dart';
import 'package:Golo/src/views/home/search/HomeSearch.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final VoidCallback homeOpenAllCities;
  final List<City> cities;

  Home({Key key, this.cities, this.homeOpenAllCities}) : super(key: key);

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: ListView(
        padding: EdgeInsets.only(top: 40),
        children: <Widget>[
          // ### 1. Header
          Container(
            margin: const EdgeInsets.only(
              top: 20,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: Text(
              Localized.of(context).trans(LocalizedKey.exploreTheWorld) ?? "",
              style: TextStyle(
                  fontFamily: GoloFont,
                  fontWeight: FontWeight.w600,
                  fontSize: 32),
            ),
          ),
          // ### 2. Search box
          GestureDetector(
              onTap: () {
                _pushHomeSearch();
              },
              child: Hero(
                tag: "home_search",
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 0,
                    left: 25,
                    right: 25,
                  ),
                  height: 50,
                  decoration: new BoxDecoration(
                      color: GoloColors.clear,
                      borderRadius: new BorderRadius.all(Radius.circular(30)),
                      border:
                          Border.all(width: 1, color: GoloColors.secondary3)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: new EdgeInsets.only(left: 20, right: 15),
                        child: Icon(
                          DenLineIcons.search,
                          size: 20,
                          color: GoloColors.secondary2,
                        ),
                      ),
                      Text(
                        Localized.of(context)
                                .trans(LocalizedKey.enterACityOrLocation) ??
                            "",
                        style: TextStyle(
                            fontFamily: GoloFont,
                            color: GoloColors.secondary3,
                            fontSize: 16),
                      )
                    ],
                  ),
                ),
              )),
          // ### 3. List cities header
          Container(
            margin: const EdgeInsets.only(
              top: 22,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    Localized.of(context).trans(LocalizedKey.popularCities) ??
                        "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 21)),
                CupertinoButton(
                  onPressed: _actionViewAllCities,
                  child: Text(
                    Localized.of(context).trans(LocalizedKey.viewAll) ?? "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: GoloColors.primary,
                        letterSpacing: 0),
                  ),
                )
              ],
            ),
          ),
          // ### 4 Cities
          Container(
              margin: EdgeInsets.only(top: 5),
              height: 280,
              child: _buildCityTable()),
          // ### 5 Article Header
          Container(
            margin: const EdgeInsets.only(
              top: 10,
              left: 25,
              right: 25,
            ),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                    Localized.of(context)
                            .trans(LocalizedKey.travelInspiration) ??
                        "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 21)),
                CupertinoButton(
                  onPressed: _actionViewMoreArticles,
                  child: Text(
                    Localized.of(context).trans(LocalizedKey.viewMore) ?? "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: GoloColors.primary,
                        letterSpacing: 0),
                  ),
                )
              ],
            ),
          ),
          // # 6 Article
          Container(height: 330, child: _buildArticleTable()),
          // #7 padding bottom
          Container(height: 50),
        ],
        scrollDirection: Axis.vertical,
      ),
    ));
  }

// ### City list
  Widget _buildCityTable() {
    return new ListView.builder(
      padding: EdgeInsets.only(left: 25),
      scrollDirection: Axis.horizontal,
      itemCount: widget.cities != null ? widget.cities.length : 0,
      itemBuilder: (BuildContext context, int index) =>
          _buildCityCell(context, index),
    );
  }

  Widget _buildCityCell(BuildContext context, int index) {
    var city = widget.cities != null ? widget.cities[index] : null;
    return Container(
        child: Container(
      margin: EdgeInsets.only(right: 8),
      width: 220,
      child: GestureDetector(
        child: CityCell(city: city),
        onTap: () {
          HomeNav(context).openCity(city);
        },
      ),
    ));
  }

// ### Article list
  Widget _buildArticleTable() => new ListView.builder(
        padding: EdgeInsets.only(left: 25),
        scrollDirection: Axis.horizontal,
        itemCount: AppState().posts != null ? AppState().posts.length : 0,
        itemBuilder: (BuildContext context, int index) =>
            _buildArticleCell(context, index),
      );

  Widget _buildArticleCell(BuildContext context, int index) {
    var post = AppState().posts != null ? AppState().posts[index] : null;
    return Container(
        child: Container(
      margin: EdgeInsets.only(right: 8),
      width: 220,
      child: GestureDetector(
        child: ArticleCell(post: post),
        onTap: () {
          _openArticle(post.link);
        },
      ),
    ));
  }

  void _openArticle(String url) async {
    MyUrlHelper.open(url);
    // if (url != null && await canLaunch(url)) {
    //   launch(url);
    // }
  }

  // ------- NAVIGATION ------
  void _pushHomeSearch() {
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 222),
        pageBuilder: (context, _, __) {
          return HomeSearchPage(cities: widget.cities);
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            child: child,
            opacity: animation,
          );
        },
        fullscreenDialog: true));
  }

  // ### ACTIONS
  void _actionViewMoreArticles() async {
    var url = "https://wp.getgolo.com/category/tips-tricks/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  void _actionViewAllCities() {
    widget.homeOpenAllCities();
  }
}
