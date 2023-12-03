import 'dart:ui';

class ColorManager{
    static final Color primary = HexColor.fromHex("#006666");
    static final Color secondary= HexColor.fromHex("#FFAC33");
}

extension HexColor on Color{
  static Color fromHex(String hexColorCode){
    hexColorCode = hexColorCode.replaceAll("#", "");
    if(hexColorCode.length == 6){
      hexColorCode= "FF$hexColorCode";
    }
    return Color(int.parse(hexColorCode,radix: 16));
  }
}