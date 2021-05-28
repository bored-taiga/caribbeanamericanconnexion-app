import 'dart:core';
import 'dart:async';
import 'package:Golo/src/providers/request_services/query/PageQuery.dart';
import 'package:http/http.dart';

class ResponseData {
  String json;
  String error;
  ResponseData(this.json, this.error);
}

enum RequestType {
  Get,
  Post
}

class Api {
  // POST
  static Future<ResponseData> requestPost(String api, Map<String, String> query, Map<String, dynamic> body) {
    return _request(RequestType.Post, _makeUrl(api, query), body: body);
  }

  // GET
  static Future<ResponseData> requestGet(String api, {Map<String, String> query}) async {
    return await _request(RequestType.Get, _makeUrl(api, query));
  }

  static Future<ResponseData> requestGetPaging(String api, PageQuery query) async {
    return await _request(RequestType.Get, _makeUrl(api, query != null ? query.toQuery() : null));
  }

  // REQUEST
  static Future<ResponseData> _request(RequestType type, String url, {Map<String, dynamic> body}) async {
    // make request
    Response response;
    switch (type) {
      case RequestType.Get:
        response = await get(url);
        break;
      case RequestType.Post:
        response = await post(url, body: body);
        break;
    }
    // sample info available in response
    int statusCode = response.statusCode;
    if (statusCode == 200) {
      return ResponseData(response.body, null);
    }
    return ResponseData(null, "Error");
  }

  static String _makeUrl(String api, Map<String, String> query) {
    var params = [];
    if (query != null) {
      query.forEach((key, value) {
        params.add(key + "=" + value);
      });
    }
    else {
      return api;
    }
    if (api.contains("?")) {
      if (api.endsWith("?")) {
        return api + params.join("&");
      }
      return api + "&" + params.join("&");
    }
    return api + "?" + params.join("&");
  }
}
