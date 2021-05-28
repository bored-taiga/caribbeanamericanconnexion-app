import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/blocs/navigation/NavigationBloc.dart';
import 'package:Golo/src/entity/City.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/src/providers/request_services/Api+search.dart';
import 'package:Golo/src/views/home/search/SearchResultCell.dart';

class HomeSearchPage extends StatefulWidget {
  // Callback events
  final List<City> cities;

  const HomeSearchPage({Key key, this.cities}) : super(key: key);

  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  
  List<Place> _searchPlaces;

  // Components
  CupertinoTextField _tfSearch;

  // Controller

  @override
  void initState() {
    super.initState();
    _searchPlaces = [];
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
          color: CupertinoColors.white,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              // # HEADER
              Container(
                margin: EdgeInsets.only(left: 25),
                height: 60,
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    // # SEARCH BOX
                    Expanded(
                      child: Hero(
                        tag: "home_search",
                        child: Container(
                          height: 50,
                          decoration: new BoxDecoration(
                              color: GoloColors.clear,
                              borderRadius:
                                  new BorderRadius.all(Radius.circular(30)),
                              border: Border.all(
                                  width: 1, color: GoloColors.secondary3)),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin:
                                    new EdgeInsets.only(left: 20, right: 15),
                                child: Icon(
                                  DenLineIcons.search,
                                  size: 20,
                                  color: GoloColors.secondary2,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: _buildSearchField(context),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // # BUTTON CANCEL
                    Container(
                      margin: EdgeInsets.only(left: 5, right: 5),
                      child: CupertinoButton(
                        onPressed: () {
                          dismiss();
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: GoloFont,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: GoloColors.primary),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: _buildResultTable(),
              )
            ],
          ))),
    );
  }

  // ### Build components
  Widget _buildSearchField(BuildContext context) {
    _tfSearch = CupertinoTextField(
      autofocus: true,
      decoration: BoxDecoration(
        color: GoloColors.clear,
        border: Border.all(width: 0, color: GoloColors.clear),

      ),
      style: TextStyle(
        fontFamily: GoloFont,
        fontSize: 16,
        color: GoloColors.secondary1
      ),
      onChanged: (text) {
        this.search(text);
      },
      onSubmitted: (text){
        FocusScope.of(context).requestFocus(FocusNode());
      },
    );
    return _tfSearch;
  }

  Widget _buildResultTable() => new ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: this._searchPlaces.length,
        itemBuilder: (BuildContext context, int index) => _buildResultCell(context, index)
  );
  GestureDetector x = GestureDetector();
  Widget _buildResultCell(BuildContext context, int index) => Container(
          child: Container(
        margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
        height: 50,
        child: SearchResultCell(
          place: this._searchPlaces[index],
          onPressedCity: _handlePressedCity,
          onPressedPlace: _handlePressedPlace,
      )
  ));

  // ### ACTIONS
  void dismiss() {
    Navigator.pop(context);
  }
  void _handlePressedCity(int cityId) {
    // Get city
    var city = widget.cities.firstWhere((c) {
      return c.id == cityId;
    });
    if (city == null) {
      return;
    }
    HomeNav(context).openCity(city);
  }

  void _handlePressedPlace(Place place) {
    HomeNav(context).openPlace(place);
  }


  // Get cities media
  Future search(String text) async {
    return ApiSearch.searchPlaces(text).then((response) {
      _searchPlaces = List<Place>.generate(
        response.json.length, 
        (i) {
          var p = Place.fromJson(response.json[i]);
          p.cityName = widget.cities.firstWhere((c) {return c.id == p.cities.first;}).name;
          return p;
        });
        setState(() {
        });
    });
  }

}
