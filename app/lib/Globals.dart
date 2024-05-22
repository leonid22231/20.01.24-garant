import 'dart:ui';

class Globals{
  static String token = "";
  static Color mainColor = Color(0xFF202125);
  static Color secondColor = Color(0xffd8ce5b);
  static Color backgroundInputColor = Color(0xff383f49);
  static Color textInputColor = Color(0xff9E9E9E);
  static Color buttonColor = Color(0xffEEE364);
  static String getToken(){
    return "Bearer ${token}";
  }
}