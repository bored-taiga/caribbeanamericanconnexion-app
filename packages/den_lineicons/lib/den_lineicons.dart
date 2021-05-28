library den_lineicons;
import 'package:flutter/widgets.dart';

// Custom IconData
class IconDataMaker extends IconData {
  const IconDataMaker(int codePoint) 
    : super(codePoint, fontFamily: 'DenLineicons', fontPackage: 'den_lineicons');
}

class DenLineIcons {
  // Den
  static const IconData city = const IconDataMaker(0xf64f);
  static const IconData bookmark = const IconDataMaker(0xf02e);
  static const IconData home = const IconDataMaker(0xf015);
  static const IconData search = const IconDataMaker(0xf002);
  static const IconData user = const IconDataMaker(0xf007);
  static const IconData angle_left = const IconDataMaker(0xf104);
  static const IconData star = const IconDataMaker(0xf005);
  static const IconData circle = const IconDataMaker(0xf111);
  static const IconData bed = const IconDataMaker(0xf236);
  static const IconData utensils = const IconDataMaker(0xf2e7);
  static const IconData shopping_bag = const IconDataMaker(0xf290);
  static const IconData binoculars = const IconDataMaker(0xf1e5);
  static const IconData share_square = const IconDataMaker(0xf14d);
  static const IconData map_marked_alt = const IconDataMaker(0xf5a0);
  static const IconData envelope = const IconDataMaker(0xf0e0);
  static const IconData phone = const IconDataMaker(0xf095);
  static const IconData globe_africa = const IconDataMaker(0xf57c);
  static const IconData facebook_square = const IconDataMaker(0xf09a);
  static const IconData instagram = const IconDataMaker(0xf16d);
  static const IconData angle_down = const IconDataMaker(0xf107);
  static const IconData angle_up = const IconDataMaker(0xf106);
  static const IconData filter = const IconDataMaker(0xf0b0);
  static const IconData cancel = const IconDataMaker(0xf00d);
  static const IconData heart = const IconDataMaker(0xf004);

}
