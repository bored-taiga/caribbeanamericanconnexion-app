
import 'package:url_launcher/url_launcher.dart';

class MyUrlHelper {
  static void _open(String url) async {
    if (url != null && await canLaunch(url)) {
     launch(url);
    }
  }

  static void open(String url) async {
    if (url == null) {
      return;
    }
    var url2 = url;
    if (!url2.contains("http")) {
      url2 = "http://$url";
    }
    _open(url2);
  }

  static void mailTo(String email) async {
    if (email != null ) {
      _open("mailto://$email?subject=Subject");
    }
  }

  static void callTo(String phone) async {
    if (phone != null) {
      _open("tel:${phone.replaceAll(new RegExp(r'[^0-9]'), "")}");
    }
  }
}