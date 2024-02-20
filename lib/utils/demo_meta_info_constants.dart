import 'dart:io';

class DemoMetaInfoConstants {
  static String name = "Sheikhani Communication";
  static String type = "Demo-App";
  static String version = "2.7.0";
  static String bundle = Platform.isAndroid
      ? "com.sheikhani.communication"
      : "com.sheikhani.communication";
  static String platform = "Flutter";
}
