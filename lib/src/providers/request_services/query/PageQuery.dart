class PageQuery {
  var perPage = 10;
  var page = 1;

  PageQuery(this.perPage, this.page);

  Map<String, String> toQuery() {
    return {
      "per_page": "$perPage", "page": "$page"
    };
  }
}
