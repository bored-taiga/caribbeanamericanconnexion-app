
import 'dart:convert';

import 'package:Golo/modules/services/http/Api.dart';
import 'package:Golo/modules/services/platform/Platform.dart';
import 'package:Golo/src/providers/request_services/response/ResponseListData.dart';

class ApiMedia {

  // Return: <slug, featuredImage>
  static Future<List<FeaturedImage>> fetchSlugThumbnails(List<String> slugs) {
    return Future.wait(slugs.map((slug) {
      var url = Platform().shared.baseUrl + "media?slug=$slug}";  // request with slug
      return Api.requestGet(url).then((response) {
        List<dynamic> items = json.decode(response.json);
        if (items != null && items.length > 0) {
          var item = items.first;
          return FeaturedImage(item["slug"], item["guid"]["rendered"]);
        }
        return null;
      });
    }).toList());
  }

  // Return: <id, featuredImage>
  static Future<List<FeaturedImage>> fetchThumbnails(List<String> ids) {
    return Future.wait(ids.map((id) {
      var url = Platform().shared.baseUrl + "media/$id"; // request with media id
      return Api.requestGet(url).then((response) {
        if (response.json != null) {
          Map<String, dynamic> item = json.decode(response.json);
          return FeaturedImage(item["id"].toString(), item["guid"]["rendered"]);
        }
        return null;
      });
    }).toList());
  }
}