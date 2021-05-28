class Base {
  int id;
  String link;
  String slug;
  String taxonomy;

  Base(Map<String, dynamic> json) {
    id = json["id"];
    link = json["link"];
    slug = json["slug"];
    taxonomy = json["taxonomy"];
  }

}