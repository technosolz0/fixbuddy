import 'package:fixbuddy/main.dart';

// class ApiConstants {
//   static const String baseUrl =  currentAppMode==live ? 'http://192.168.43.227:8000': ;
//   // static const String baseUrl = 'http://127.0.0.1:8000/api/';
// }
class ApiConstants {
  static String testUrl = 'http://10.158.55.167:8000';
  static String liveUrl = 'http://10.158.55.167:8000';
  // static String liveUrl = 'https://api.thelifetrackr.com';
  static String baseUrl =
      (currentAppMode == AppMode.test || currentAppMode == AppMode.dev)
      ? testUrl
      : liveUrl;
}
