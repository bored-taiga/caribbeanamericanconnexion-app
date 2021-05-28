import 'package:Golo/modules/services/platform/PlatformBase.dart';

class WP extends PlatformBase {
  WP() : super() {
    baseUrl = "http://caribconnexion.com/wp-json/wp/v2/";
  }
}