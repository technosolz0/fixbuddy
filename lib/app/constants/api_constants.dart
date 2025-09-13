import 'package:fixbuddy/main.dart';

// class ApiConstants {
//   static const String baseUrl =  currentAppMode==live ? 'http:// 10.33.208.167:8000': ;
//   // static const String baseUrl = 'http://127.0.0.1:8000/api/';
// }
class ApiConstants {
  static String testUrl = 'http://194.164.148.133:8003';
  static String liveUrl = 'http://194.164.148.133:8003';
  static String baseUrl =
      (currentAppMode == AppMode.test || currentAppMode == AppMode.dev)
      ? testUrl
      : liveUrl;
}
