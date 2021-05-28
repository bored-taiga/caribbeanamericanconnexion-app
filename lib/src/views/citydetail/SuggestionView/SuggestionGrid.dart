import 'package:den_lineicons/den_lineicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Golo/src/entity/PlaceCategory.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/modules/setting/colors.dart';
import 'package:Golo/modules/setting/fonts.dart';
import 'package:Golo/src/views/citydetail/Filter/FilterPlaceView.dart';
import 'package:Golo/src//views/citydetail/SuggestionView/SuggestionCell.dart';


class SuggestionGrid extends StatefulWidget {
  final PlaceCategory category;
  final List<Place> places;
  // event
  final void Function(Place) handleOpenPlace; // open place with id

  SuggestionGrid({this.category, this.places, this.handleOpenPlace});
  @override
  _SuggestionGrid createState() {
    return _SuggestionGrid();
  }
}

class _SuggestionGrid extends State<SuggestionGrid> {
  List<Place> places;
  List<String> selectedPriceOptions= [];
  List<String> selectedTypesoptions= [];
  List<String> selectedAmenityOptions= [];
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedPriceOptions.length == 0 && selectedTypesoptions.length == 0 && selectedAmenityOptions.length == 0) 
      places = widget.places;
    return Container(
        margin: EdgeInsets.only(top: 20, left: 0, right: 0),
        child: Column(
          children: <Widget>[
            //Category
            Container(
              height: 60,
              margin: EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.category.name ?? "",
                    style: TextStyle(
                        fontFamily: GoloFont,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: GoloColors.secondary1),
                  ),
                  CupertinoButton(
                    onPressed: () {
                      navigateToFilterView();
                    },
                    child: Stack(
                        alignment: Alignment.centerRight,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Icon(DenLineIcons.filter,
                                size: 20, color: GoloColors.secondary2),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Visibility(
                              visible: selectedPriceOptions.isNotEmpty || selectedAmenityOptions.isNotEmpty || selectedTypesoptions.isNotEmpty,
                              child: Container(
                                padding: EdgeInsets.only(right: 0),
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                    color: GoloColors.primary,
                                    shape: BoxShape.circle),
                              ),
                            )
                          )
                        ]),
                  )
                ],
              ),
            ),
            // Grid view

            Container(
                margin: EdgeInsets.only(left: 25, right: 25),
                child: _buildSuggestionGridView()),
          ],
        ));
  }

//GridView
  Widget _buildSuggestionGridView() => GridView.count(
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.all(0),
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
      childAspectRatio: 0.715,
      shrinkWrap: true,
      children: List.generate(places.length, (index) {
        return _buildSuggestionGridViewCell(index);
      }));

  //  new Wrap(
  //     direction: Axis.horizontal,
  //     textDirection: TextDirection.ltr,
  //     runSpacing: 10,
  //     spacing: 10,
  //     children: List.generate(widget.places.length, (index) {
  //       return _buildSuggestionGridViewCell(index);
  //     }));

  Widget _buildSuggestionGridViewCell(int index) => GestureDetector(
      onTap: () {
        widget.handleOpenPlace(places[index]);
      },
      // child: Expanded(
      child: Container(
        // height: 250,
        // width: 170,
        child: SuggestionCell(place: places[index]),
      )
      // ),
      );

  //Navigator to filter
  void navigateToFilterView() {
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        opaque: true,
        transitionDuration: const Duration(milliseconds: 222),
        pageBuilder: (BuildContext context, _, __) {
          return FilterCityDetail(
            onFilter: filter,
            selectedOptionAmenities: selectedAmenityOptions,
            selectedOptionPrices: selectedPriceOptions,
            selectedOptionTypes: selectedTypesoptions,
          );
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            child: child,
            position:
                animation.drive(Tween(begin: Offset(0, 1), end: Offset.zero)),
          );
        },
        fullscreenDialog: true));
  }
  void filter(List<String> prices, List<String> types, List<String> amenities) {
    setState(() {
      this.selectedPriceOptions = prices;
      this.selectedTypesoptions = types;
      this.selectedAmenityOptions = amenities;
      places = widget.places;
      if (prices.length > 0) {
        places =
            places.where((place) => prices.contains(place.priceRange)).toList();
      }
      if (types.length > 0) {
        places = places.where((place) {
          List<String> tmpTypes = place.types.map((type) => "$type").toList();
          
          return types.toSet()
                  .intersection(tmpTypes.toSet())
                  .length >
              0;
        }).toList();
      }
      if (amenities.length > 0) {
        places = places.where((place) {
          List<String> tmpAmenity = place.amenities.map((amenity) => "$amenity");
          return amenities.toSet()
                  .intersection(tmpAmenity.toSet())
                  .length >
              0;
        }).toList();
      }
    });
  }
}

// class SuggestionColumn extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _SuggestionColumn();
//   }
// }

// class _SuggestionColumn extends State<SuggestionColumn> {
//   @override
//   void initState() {
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(),
//     );
//   }

//   Widget _createSuggestRow() => Row(children: <Widget>[],)

// }
