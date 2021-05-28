

class ResponseListData {
  List<dynamic> json;
  String error;
  ResponseListData(this.json, this.error);
}

class FeaturedImage {
  String slug; // slug | id
  String url;
  FeaturedImage(this.slug, this.url);
}