import 'dart:async';
import 'package:Golo/modules/setting/setting.dart';
import 'package:Golo/src/blocs/Bloc.dart';
import 'package:Golo/src/entity/Place.dart';
import 'package:Golo/src/providers/request_services/PlaceProvider.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';

class CityDetailBloc implements Bloc {

  // Data
  var _currentPage = 1;
  var places = <Place>[];
  var _groupedPlaces = Map<int, List<Place>>();
  Map<int, List<Place>> get groupedPlaces => _groupedPlaces;

  // Stream
  final _placeController = StreamController<List<Place>>.broadcast();
  Stream<List<Place>> get placesStream => _placeController.stream;

  void fetchPlaces(int cityId) async {
    final response = await PlaceProvider.getPlaces("$cityId", query: PageQuery(Setting.requestItemPerPage, _currentPage));
    print("Fetched places of city $cityId at page $_currentPage");
    _currentPage++;
    List<Place> tmp;
    if (response.json != null && response.json.isNotEmpty) {
      tmp = List<Place>.generate(response.json.length, (i) => Place.fromJson(response.json[i]));
      places.addAll(tmp);
      _groupData(tmp);
      _placeController.sink.add(places);
      // Request next
      fetchPlaces(cityId);
    }
  }

  void _groupData(List<Place> all) {
    for (var item in all) {
      for (var cat in item.categories) {
        if (_groupedPlaces[cat] == null) {
          _groupedPlaces[cat] = [item];
        }
        else {
          _groupedPlaces[cat].add(item);
        }
      }
    }
  }

  @override
  void dispose() {
    _placeController.close();
  }


}
