
import 'dart:convert';

import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/src/entity/Comment.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';

class PlaceProvider {


  static Future<ResponseListData> getPlaces(String cityId, {PageQuery query}) {
    var url = Platform().shared.baseUrl + "place?place-city=$cityId";
    return Api.requestGetPaging(url, query).then((data) {
      var placesJson = data.json != null ? json.decode(data.json) : null;
      return ResponseListData(placesJson, data.error);
    });
  }

  static Future<ResponseListData> getPlaceTypes({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-type";
    return Api.requestGetPaging(url, query).then((data) {
      var typesJson = data.json != null ? json.decode(data.json) : null;
      return ResponseListData(typesJson, data.error);
    });
  }

  static Future<List<Comment>> getPlaceComments(int placeId, {PageQuery query}) {
    var url = Platform().shared.baseUrl + "comments?post=$placeId";
    return Api.requestGetPaging(url, query).then((response) {
      List<dynamic> items = json.decode(response.json);
      if (items != null && items.length > 0) {
          return List<Comment>.generate(items.length, (i) => Comment(items[i]));
      }
      return null;
    });
  }

}