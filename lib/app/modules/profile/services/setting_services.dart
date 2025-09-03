import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:get/get.dart';

class SettingServices {
  static String subMitFeedbackEnd = "/SubmitFeedback";
  static String updatePasswordEnd = "/UpdatePassword";
  static String requestAccountDeletionEnd = "/RequestAccountDeletion";
  static Future sendFeedBack(String id, String feedback, int rating) async {
    try {
      String jwtToken = await LocalStorage().getToken() ?? '';
      Map data = {
        "userId": id,
        "feedback": feedback,
        "rating": rating.toString(),
      };
      ServexUtils.dPrint('-->data: $data');
      var response = await Dio(ServexUtils.getDioOptions).post(
        "${ApiConstants.baseUrl}$subMitFeedbackEnd",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $jwtToken",
          },
        ),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        Get.back();
        // ServexUtils.showSnackbar("Alert", "Your feedback has been recorded");
      } else {
        ServexUtils.showSnackbar("Error" as SnackType, "Some error occured.");
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  static Future requestAccountDeletion(
    String id,
    String reason,
  ) async {
    try {
      String jwtToken = await LocalStorage().getToken() ?? '';
      Map data = {
        "userId": id,
        "reason": reason,
      };
      ServexUtils.dPrint('--->account deletion request: $data');
      var response = await Dio(ServexUtils.getDioOptions).post(
        "${ApiConstants.baseUrl}$requestAccountDeletionEnd",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $jwtToken",
          },
        ),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        Get.back();
        ServexUtils.showSnackbar("Alert" as SnackType, "Your request has been submitted");
        // FAnalytics.logAccountDeletionRequest(reason: reason);
      } else {
        ServexUtils.showSnackbar("Error" as SnackType, "Some error occured.");
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  static Future updatePassword(
    String id,
    String oldPass,
    String newPass,
  ) async {
    try {
      String jwtToken = await LocalStorage().getToken() ?? '';
      Map data = {
        "userId": id,
        "currentPassword": oldPass,
        "newPassword": newPass
      };
      var response = await Dio(ServexUtils.getDioOptions).post(
        "${ApiConstants.baseUrl}$updatePasswordEnd",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $jwtToken",
          },
        ),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        Get.back();
        ServexUtils.showSnackbar("Alert" as SnackType, "Your password updated successfully");
      } else {
        ServexUtils.showSnackbar("Error" as SnackType, "Some error occured.");
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }
}
