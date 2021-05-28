
import 'package:Golo/modules/state/AppState.dart';
import 'package:Golo/src/entity/Comment.dart';
import 'package:html/parser.dart';

import 'Base.dart';

class Place extends Base{
  String status;
  String type;
  String imgUrl;
  String featuredMediaUrl;
  int menuOrder;
  int author;
  String commentStatus;
  String pingStatus;
  String template;
  List<int> types; // Place types id
  List<int> categories; // categories
  List<int> amenities;
  List<int> cities;
  String content;
  String title;
  String excerpt;
  // Location
  String location;
  String address;
  // Manual get
  String cityName;
  List<Comment> _comments = [];
  int reviewCount;
  // Rate
  String _rate;
  String get rate {
    return hasRate ? _rate : "(No review)";
  }
  bool get hasRate {
    return _rate != null && _rate.isNotEmpty;
  }
  // Price range
  String priceRange;
  // Phone - email - site - facebook - instagram
  String phone;
  String email;
  String facebook;
  String instagram;
  String website;
  // Booking
  String booking;
  String bookingSite;
  String bookingType;
  String bookingBannerId;
  String bookingBannerImageUrl;
  String bookingBannerUrl;
  String bookingForm;
  // Opening time
  Map<String, String> openingTime = {};
  
  Place(Map<String, dynamic> json) : super(json) {
    status = json["status"];
    type = json["type"];
    featuredMediaUrl = json["featured_media_url"];
    menuOrder = json["menu_order"];
    author = json["author"];
    pingStatus = json["ping_status"];
    template = json["template"];
    content = parse(json["content"]["rendered"] ?? "").documentElement.text;
    title = parse(json["title"]["rendered"]).documentElement.text;
    excerpt = parse(json["excerpt"]["rendered"] ?? "").documentElement.text;
    // place type
    types = json["place-type"] != null ? json["place-type"].cast<int>() : [];
    // cateogries
    categories = json["place-categories"] != null ? json["place-categories"].cast<int>() : [];
    // amenities
    amenities = json["place-amenities"] != null ? json["place-amenities"].cast<int>() : [];
    // cities
    cities = json["place-city"] != null ? json["place-city"].cast<int>() : [];
    location = json["golo-place_location"]["location"];
    address =  json["golo-place_location"]["address"];
    // rate
    _rate = json["golo-place_rating"];
    // Price range
    var value = json["golo-place_price_range"];
    if (value == null || value == "none") {
      priceRange = "";
    }
    else if (value == "free") {
      priceRange = "free";
    }
    else {
      var count = int.tryParse(value);
      priceRange = List<String>.generate(count, (int i) => r"$").join();
    }
    // other
    phone = json["golo-place_phone"];
    email = json["golo-place_email"];
    facebook = json["golo-place_facebook"];
    instagram = json["golo-place_instagram"];
    website = json["golo-place_website"];
    // booking
    booking = json["golo-place_booking"];
    bookingSite = json["golo-place_booking_site"];
    bookingType = json["golo-place_booking_type"];
    if (bookingType == "banner") {
      bookingBannerId = json["golo-place_booking_banner"]["id"];
      bookingBannerImageUrl = json["golo-place_booking_banner"]["url"];
    }
    bookingBannerUrl = json["golo-place_booking_banner_url"];
    bookingForm = json["golo-place_booking_form"];
    // Opening time
    /*
    "golo-opening_monday": "Monday",
  "golo-opening_monday_time": "11:00 AM–9:00 PM",
  "golo-opening_tuesday": "Tuesday",
  "golo-opening_tuesday_time": "11:00 AM–9:00 PM",
  "golo-opening_wednesday": "Wednesday",
  "golo-opening_wednesday_time": "11:00 AM–9:00 PM",
  "golo-opening_thursday": "Thursday",
  "golo-opening_thursday_time": "11:00 AM–9:00 PM",
  "golo-opening_friday": "Friday",
  "golo-opening_friday_time": "11:00 AM–9:00 PM",
  "golo-opening_saturday": "Saturday",
  "golo-opening_saturday_time": "11:00 AM–9:00 PM",
  "golo-opening_sunday": "Sunday",
  "golo-opening_sunday_time": "11:00 AM–9:00 PM",
    */
    var arr = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];
    openingTime = {};

    for (int i = 0; i < arr.length; i++) {
      var name = json["golo-opening_${arr[i]}"].toString();
      var time = json["golo-opening_${arr[i]}_time"].toString();
      if (name != null && name.isNotEmpty && time != null && time.isNotEmpty) {
        openingTime[name] = time;
      }
    }

    // Review count
    reviewCount = json["golo-review_count"];
  }
  
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(json);
  }

  String getCategoryName() {
    return AppState().categories.firstWhere((cat){return cat.id == categories.first;}).name;
  }

  List<Comment> get comments => _comments;
  void setComments(List<Comment> list) {
    _comments = list ?? [];
  }


}
