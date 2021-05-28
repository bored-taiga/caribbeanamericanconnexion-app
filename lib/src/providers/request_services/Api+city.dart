import 'dart:convert';

import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';



class ApiCity {
  static Future<ResponseListData> fetchCities({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-city";
    return Api.requestGetPaging(url, query).then((data) {
      return ResponseListData(json.decode(data.json), data.error);
    });
  }

  static Future<ResponseData> fetchCity(String id) {
    var url = Platform().shared.baseUrl + "place-city/$id";
    return Api.requestGet(url);
  }

  // Category
  static Future<ResponseListData> fetchCategories({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-categories";
    return Api.requestGetPaging(url, query).then((data) {
      return ResponseListData(json.decode(data.json), data.error);
    });
  }

  // Amenities
  static Future<ResponseListData> fetchAmenities({PageQuery query}) {
    var url = Platform().shared.baseUrl + "place-amenities";
    return Api.requestGetPaging(url, query).then((data) {
      return ResponseListData(json.decode(data.json), data.error);
    });
  }
  
}
