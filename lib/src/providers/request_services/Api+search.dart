
import 'dart:convert';

import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';

class ApiSearch {

  static Future<ResponseListData> searchPlaces(String text) {
    var url = Platform().shared.baseUrl + "place?search=$text";
    return Api.requestGet(url).then((data) {
      return ResponseListData(json.decode(data.json), data.error);
    });
  }
}