
import 'package:Golo/modules/services/platform/PlatformBase.dart';
import 'package:Golo/modules/services/platform/lara/lara.dart';
import 'package:Golo/modules/services/platform/wp/wp.dart';

enum PlatformType {
  lara,
  wp
}

class Platform {
  static final Platform _instance = Platform._internal();

  factory Platform() {
    return _instance;
  }

  // Properties
  var type = PlatformType.wp;
  PlatformBase shared;

  Platform._internal() {
    switch (type) {
      case PlatformType.lara:
        shared = Lara();
        break;
      case PlatformType.wp:
        shared = WP();
        break;
    }
  }

  


}