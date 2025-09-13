import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fixbuddy/app/constants/api_constants.dart';
import 'package:fixbuddy/app/constants/custom_overlay.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:fixbuddy/app/utils/servex_utils.dart';
import 'package:path/path.dart';

class ProfileServices {
  static String fetchUserBio = "/FetchUserBio";
  static String updateUserBio = "/UpdateUserBio";
  static String getMyProfile = "/GetMyProfile";
  static String fetchUserDiscussions = "/FetchUserDiscussions";
  static String fetchUserRelations = "/FetchUserRelations";
  static String updateProfileUrl = "/UpdateProfile";
  static String fetchBookmarkedDiscussions = "/FetchBookmarkedDiscussions";
  static String fetchUserPDF = "/FetchUserPDF";
  static String fetchBookmarkedSubmissionArticles =
      "/FetchBookmarkedSubmissionArticles";
  static String getSurveysList = '/GetSurveysList';
  static String getMatrixHistoryPath = '/GetMatrixHistory';
  static String fetchAvailableRewardsPath = '/FetchAvailableRewards';
  static String fetchRedeemedRewardsPath = '/FetchRedeemedRewards';
  static String fetchRewardDetailsPath = '/FetchRewardDetails';
  static String redeemRewardPath = '/RedeemReward';
  static String fetchLikeActivitiesPath = '/FetchLikeActivity';
  static String fetchCommentActivitiesPath = '/FetchCommentActivity';
  static String fetchActionPointsPath = '/FetchActionPoints';
  static String fetchMatrixPointsPath = '/FetchMatrixPoints';

  static Future<String> fetchBio(String id) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {"userId": id};
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchUserBio",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data["bio"];
      } else {
        return "";
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return "";
    }
  }

  static Future updateBio(String id, String bio) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';

    Map data = {"userId": id, "bio": bio};
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$updateUserBio",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        ServexUtils.showSnackbar(
          "Success" as SnackType,
          "Your bio updated successfully",
        );
      } else {}
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  static Future fetchProfile(String id) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';

    Map data = {"userId": id};
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$getMyProfile",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        String data = json.encode(response.data['data']);
        LocalStorage().saveDataToLocal(LocalStorage.userProfile, data);
        return response.data['data'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      Map data = await LocalStorage().getMapDataFromLocal(
        LocalStorage.userProfile,
      );
      return data.isEmpty ? null : data;
    }
  }

  ///type 1-->approved, 2-->pending, 3-->rejected
  static Future fetchDiscussion(
    String id, {
    int page = 1,
    int count = 10,
    int type = 1,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {
      "userId": id,
      "type": type,
      "offset": page,
      "record_Count": count,
    };
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchUserDiscussions",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );

      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data['resultList'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);

      return;
    }
  }

  static Future fetchRelation(
    String id,
    int type, [
    int page = 1,
    int count = 10,
  ]) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {
      "userId": id,
      "type": type,
      "offset": page,
      "record_Count": count,
    };
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchUserRelations",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );

      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data['users'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);

      return;
    }
  }

  static Future updateProfile(
    String id,
    Map<String, dynamic> map,
    File? img,
  ) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    ServexUtils.dPrint(
      '--->update profile data: $map , url:$updateProfileUrl, jwt:$jwtToken',
    );

    map["userId"] = id;
    FormData formData = FormData.fromMap({
      "img": img != null && img.path.isNotEmpty
          ? await MultipartFile.fromFile(img.path, filename: basename(img.path))
          : null,
    });

    try {
      Response response = await dio.post(
        updateProfileUrl,
        data: formData,
        options: Options(
          headers: {"Authorization": "Bearer $jwtToken", ...map},
        ),
      );
      ServexUtils.dPrint(response.data);
      if (response.data['result'] == 1) {
        Map<String, dynamic> fireMap = {
          "name": "${map['firstName']} ${map['lastName']}",
        };
        if (response.data['img'] != null) {
          fireMap['image'] = response.data['img'];
        }
        // ConnectToFire.updateProfile(map: fireMap, docId: id);
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  // static Future<List<RedeemTileModel>> fetchAvailableRewards({
  //   required int offset,
  //   required int recordCount,
  // }) async {
  //   Dio dio = Dio(ServexUtils.getDioOptions);
  //   String jwtToken = await LocalStorage().getToken() ?? '';
  //   String id = await LocalStorage().getUserID() ?? '';
  //   Map data = {"userId": id, "offset": offset, "recordCount": recordCount};
  //   ServexUtils.dPrint('--->data: $data');
  //   try {
  //     var response = await dio.post(
  //       "${ApiConstants.baseUrl}$fetchAvailableRewardsPath",
  //       data: data,
  //       options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
  //     );
  //     ServexUtils.dPrint('--->response: $response');
  //     if (response.statusCode == 200 && response.data["result"] == 1) {
  //       return RedeemTileModel.listFromJSON(
  //         List<Map<String, dynamic>>.from(
  //           response.data['availableRewardsList'],
  //         ),
  //       );
  //     } else {
  //       return [];
  //     }
  //   } on DioException catch (e) {
  //     ServexUtils.dioExceptionHandler(e);
  //     return [];
  //   }
  // }

  // static Future<List<RedeemTileModel>> fetchRedeemedRewards({
  //   required int offset,
  //   required int recordCount,
  // }) async {
  //   Dio dio = Dio(ServexUtils.getDioOptions);
  //   String jwtToken = await LocalStorage().getToken() ?? '';
  //   String id = await LocalStorage().getUserID() ?? '';
  //   Map data = {"userId": id, "offset": offset, "recordCount": recordCount};
  //   ServexUtils.dPrint('--->data: $data');
  //   try {
  //     var response = await dio.post(
  //       "${ApiConstants.baseUrl}$fetchRedeemedRewardsPath",
  //       data: data,
  //       options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
  //     );
  //     ServexUtils.dPrint('--->response: $response');
  //     if (response.statusCode == 200 && response.data["result"] == 1) {
  //       return RedeemTileModel.listFromJSON(
  //         List<Map<String, dynamic>>.from(response.data['redeemedRewards']),
  //       );
  //     } else {
  //       return [];
  //     }
  //   } on DioException catch (e) {
  //     ServexUtils.dioExceptionHandler(e);
  //     return [];
  //   }
  // }

  // static Future<RewardModel> fetchRewardDetails({required String id}) async {
  //   Dio dio = Dio(ServexUtils.getDioOptions);
  //   String jwtToken = await LocalStorage().getToken() ?? '';
  //   int? userId = await LocalStorage().getUserID() ?? 0;
  //   Map data = {"userId": userId, "rewardId": id};
  //   ServexUtils.dPrint('--->data: $data');
  //   try {
  //     var response = await dio.post(
  //       "${ApiConstants.baseUrl}$fetchRewardDetailsPath",
  //       data: data,
  //       options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
  //     );
  //     if (response.statusCode == 200 && response.data["result"] == 1) {
  //       return RewardModel.fromJSON(response.data['reward']);
  //     } else {
  //       return RewardModel.initalize();
  //     }
  //   } on DioException catch (e) {
  //     ServexUtils.dioExceptionHandler(e);
  //     return RewardModel.initalize();
  //   }
  // }

  static Future<Map<String, dynamic>> redeemReward({required String id}) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    int? userId = await LocalStorage().getUserID() ?? 0;
    Map data = {"userId": userId, "rewardId": id};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$redeemRewardPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      ServexUtils.dPrint('--->response: $response');
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {};
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return {};
    }
  }

  static Future<List<List<int>>> fetchMatrixPoints() async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchMatrixPointsPath",
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        List<List<int>> p = [];
        List r = response.data['data'];
        for (int i = 0; i < r.length; i++) {
          p.add(List<int>.from(r[i]));
        }
        return p;
      } else {
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }
}
