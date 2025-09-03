import 'dart:convert';
import 'dart:developer';
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
        ConnectToFire.updateProfile(map: fireMap, docId: id);
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
    }
  }

  static Future fetchBookMarkedDiscussion(
    String id, [
    int page = 1,
    int count = 10,
  ]) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {"userId": id, "offset": page, "record_Count": count};
    ServexUtils.dPrint('--->data: $data');
    try {
      Response response = await dio.post(
        "${ApiConstants.baseUrl}$fetchBookmarkedDiscussions",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );

      ServexUtils.dPrint(
        '--->user bookmarked discussions result: ${response.data}',
      );

      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data['discussions'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);

      return;
    }
  }

  static Future fetchBookMarkedArticle(
    String id, [
    int page = 1,
    int count = 10,
  ]) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {"userId": id, "offset": page, "record_Count": count};
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchBookmarkedSubmissionArticles",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );

      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data['submissionArticles'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);

      return;
    }
  }

  static Future fetchProfilePdf(
    String id,
    int type, [
    int page = 1,
    int count = 10,
  ]) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    Map data = {
      "userId": id,
      "offset": page,
      "record_Count": count,
      "type": type,
    };
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchUserPDF",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );

      if (response.statusCode == 200 && response.data["result"] == 1) {
        return response.data['pdfs'];
      } else {
        return null;
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return;
    }
  }

  //get surveys
  Future<List<ProfileSurveyModel>> getSurveys(
    int offset,
    int recordCount,
  ) async {
    final Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    try {
      final String url = ApiConstants.baseUrl + getSurveysList;

      String userId = await LocalStorage().getUserID() ?? "";
      Map<String, dynamic> data = {
        "userId": userId,
        "offset": offset,
        "record_Count": recordCount,
      };

      ServexUtils.dPrint('-->data: $data');

      //result 1-->success, 2-->error
      Response response = await dio.post(
        url,
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200) {
        final int result = int.parse(response.data['result'].toString());
        if (result == 1 && response.data["data"] != null) {
          return ProfileSurveyModel.listFromJSON(
            List<Map<String, dynamic>>.from(response.data["data"]),
          );
        } else {
          return [];
        }
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      ServexUtils.dPrint('--->fetch survey list error:$e');
    }
    return [];
  }

  static Future<List<MatrixHistoryTileModel>> fetchMatrixHistory({
    required int offset,
    required int recordCount,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String id = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": id, "offset": offset, "record_Count": recordCount};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$getMatrixHistoryPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        List<MatrixHistoryTileModel> history = [];
        List<Map<String, dynamic>> rawData = List<Map<String, dynamic>>.from(
          response.data['history'],
        );
        for (int i = 0; i < rawData.length; i++) {
          history.add(MatrixHistoryTileModel.fromJSON(rawData[i]));
        }
        return history;
      } else {
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }

  static Future<List<RedeemTileModel>> fetchAvailableRewards({
    required int offset,
    required int recordCount,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String id = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": id, "offset": offset, "recordCount": recordCount};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchAvailableRewardsPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      ServexUtils.dPrint('--->response: $response');
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return RedeemTileModel.listFromJSON(
          List<Map<String, dynamic>>.from(
            response.data['availableRewardsList'],
          ),
        );
      } else {
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }

  static Future<List<RedeemTileModel>> fetchRedeemedRewards({
    required int offset,
    required int recordCount,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String id = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": id, "offset": offset, "recordCount": recordCount};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchRedeemedRewardsPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      ServexUtils.dPrint('--->response: $response');
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return RedeemTileModel.listFromJSON(
          List<Map<String, dynamic>>.from(response.data['redeemedRewards']),
        );
      } else {
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }

  static Future<RewardModel> fetchRewardDetails({required String id}) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String userId = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": userId, "rewardId": id};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchRewardDetailsPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return RewardModel.fromJSON(response.data['reward']);
      } else {
        return RewardModel.initalize();
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return RewardModel.initalize();
    }
  }

  static Future<Map<String, dynamic>> redeemReward({required String id}) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String userId = await LocalStorage().getUserID() ?? '';
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

  static Future<List<ActivityModel>> fetchLikeActivities({
    required int offset,
    required int recordCount,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String userId = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": userId, "offset": offset, "recordCount": recordCount};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchLikeActivitiesPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        log('--->liked activity: ${response.data['liked']}');
        return ActivityModel.listFromJSON(
          List<Map<String, dynamic>>.from(response.data['liked']),
        );
      } else {
        ServexUtils.showSnackbar('Error', 'Some error occured');
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }

  static Future<List<ActivityModel>> fetchCommentActivities({
    required int offset,
    required int recordCount,
  }) async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    String userId = await LocalStorage().getUserID() ?? '';
    Map data = {"userId": userId, "offset": offset, "recordCount": recordCount};
    ServexUtils.dPrint('--->data: $data');
    try {
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchCommentActivitiesPath",
        data: data,
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return ActivityModel.listFromJSON(
          List<Map<String, dynamic>>.from(response.data['commented']),
        );
      } else {
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> fetchActionPoints() async {
    Dio dio = Dio(ServexUtils.getDioOptions);
    String jwtToken = await LocalStorage().getToken() ?? '';
    try {
      String userId = await LocalStorage().getUserID() ?? '';
      var response = await dio.post(
        "${ApiConstants.baseUrl}$fetchActionPointsPath",
        data: {"userId": userId},
        options: Options(headers: {"Authorization": "Bearer $jwtToken"}),
      );
      if (response.statusCode == 200 && response.data["result"] == 1) {
        return List<Map<String, dynamic>>.from(response.data['data']);
      } else {
        ServexUtils.showSnackbar('Error', 'Some error occured');
        return [];
      }
    } on DioException catch (e) {
      ServexUtils.dioExceptionHandler(e);
      return [];
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
