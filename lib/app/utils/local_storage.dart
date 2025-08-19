import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';

class LocalStorage {
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  late FlutterSecureStorage pref;

  LocalStorage() {
    pref = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  Future clearLocalStorage() async {
    String? prevLang = await getLanguage();
    bool? prevIsDarkMode = await getIsDarkMode();
    await pref.deleteAll(aOptions: _getAndroidOptions());
    if (prevLang != null) {
      await setLanguage(prevLang);
    }
    if (prevIsDarkMode != null) {
      await setIsDarkMode(prevIsDarkMode);
    }
  }

  // general shared pref keys
  final String tokenKey = 'tokenKey'; //to save jwt token
  final String firebaseTokenKey =
      'firebaseTokenKey'; //to save firebase FCM token
  final String userIDKey = 'userIDKey'; //to save userID
  final String lastLoginDateKey = 'loastLoginDateKey'; //to save last login date
  final String userLanguageKey = 'userLanguageKey'; //to save user's language
  final String lastFCMUpdatedAtKey = 'lastFCMUpdatedAtKey';
  final String lastSentFCMKey = 'lastSentFCMKey';
  final String isOnboardedKey =
      'isOnboardedKey'; // to save if the user is onboarded
  final String hasResetPasswordKey = 'hasResetPasswordKey';
  final String allGoalsProvidedKey =
      'allGoalsProvidedKey'; //to save if the user has provided all of the goals
  final String userDetailsKey = 'userDetailsKey';
  final String isDarkModeKey = 'isDarkModeKey';

  //task reminders related keys
  final String reminderPreferenceKey = 'reminderPreferenceKey';
  final String preferredCalIdKey = 'preferredCalIdKey';
  final String addedCalendarEventIdKey = 'addedCalendarEventIdKey';
  final String addedRemindersKey = 'addedRemindersKey';

  final String homeDataKey = 'homeDataKey';
  final String lastHomeDataFetchedAtKey = 'lastHomeDataFetchedAtKey';
  final String lastStepsUpdatedAtKey = 'lastStepsUpdatedAtKey';
  final String lastAssessmentRemindedAt = 'lastAssessmentRemindedAtKey';
  final String userOptedForManualStepsKey = 'userOptedForManualStepsKey';
  final String hasFetchedStepsProgressTodayKey =
      'hasFetchedStepsProgressTodayKey';
  final String stepsProgressTrackingKey = 'stepsProgressTrackingKey';
  final String userBadgesKey = 'userBadgesKey';

  final String communityDataKey = 'communityDataKey';
  final String userBuddiesKey = 'userBuddiesKey';
  final String userSentBuddyRequestsKey = 'userSentBuddyRequestsKey';

  final String hasIOSHealthPermissionKey = 'hasIOHealthPermissionKey';

  final String lastAssessedAtKey = 'lastAssessedAtKey';

  final String stepsDataKey = 'stepsDataKey';
  final String stepsPreferenceKey = 'stepsPreferenceKey';

  /// To save jwt token to cache. Pass `String`
  Future setToken(String val) async {
    await pref.write(key: tokenKey, value: val);
  }

  /// To fetch jwt token from cache. Returns `String?`
  Future<String?> getToken() async {
    return await pref.read(key: tokenKey);
  }

  /// To save firebase token to cache. Pass `String`
  Future setFirebaseToken(String val) async {
    await pref.write(key: firebaseTokenKey, value: val);
  }

  /// To fetch firebase token from cache. Returns `String?`
  Future<String?> getFirebaseToken() async {
    return await pref.read(key: firebaseTokenKey);
  }

  /// To save userID to cache. Pass `String`
  /// To save userID to cache. Pass `int`
  Future setUserID(int val) async {
    await pref.write(key: userIDKey, value: val.toString());
  }

  /// To fetch userID from cache. Returns `int?`
  Future<int?> getUserID() async {
    String? userIdString = await pref.read(key: userIDKey);
    if (userIdString == null) return null;
    return int.tryParse(userIdString);
  }
  /// To save last login date to cache. Pass `DateTime`
  Future setLastLoginDate(DateTime val) async {
    await pref.write(key: lastLoginDateKey, value: val.toString());
  }

  /// To fetch last login date from cache. Returns `DateTime?`
  Future<DateTime?> getLastLoginDate() async {
    String? lastLoginDateString = await pref.read(key: lastLoginDateKey);
    if (lastLoginDateString == null) return null;
    return DateTime.parse(lastLoginDateString);
  }

  /// To save user's language to cache. Pass `String`
  Future setLanguage(String val) async {
    await pref.write(key: userLanguageKey, value: val);
  }

  /// To fetch user's language from cache. Returns `String?`
  Future<String?> getLanguage() async {
    return await pref.read(key: userLanguageKey);
  }

  /// To save last FCM updated at date to cache. Pass `DateTime`
  Future setLastFCMUpdatedAtDate(DateTime val) async {
    await pref.write(key: lastFCMUpdatedAtKey, value: val.toString());
  }

  /// To fetch last FCM updated at date from cache. Returns `DateTime?`
  Future<DateTime?> getLastFCMUpdatedAtDate() async {
    String? lastFCMUpdatedAtDateString = await pref.read(
      key: lastFCMUpdatedAtKey,
    );
    if (lastFCMUpdatedAtDateString == null) return null;
    return DateTime.parse(lastFCMUpdatedAtDateString);
  }

  /// To save last sent FCM to cache. Pass `String`
  Future setLastSentFCM(String val) async {
    await pref.write(key: lastSentFCMKey, value: val);
  }

  /// To fetch last sent FCM from cache. Returns `String?`
  Future<String?> getLastSentFCM() async {
    return await pref.read(key: lastSentFCMKey);
  }

  /// To save if user is onboarded. Pass `bool`
  Future setIsOnboarded(bool val) async {
    await pref.write(key: isOnboardedKey, value: val.toString());
  }

  /// To fetch if user is onboarded from cache. Returns `bool?`
  Future<bool> getIsOnboarded() async {
    return bool.parse(await pref.read(key: isOnboardedKey) ?? 'false');
  }

  /// To save if user has resetted password. Pass `bool`
  Future setHasResetPassword(bool val) async {
    await pref.write(key: hasResetPasswordKey, value: val.toString());
  }

  /// To fetch if user has resetted password from cache. Returns `bool?`
  Future<bool> getHasResetPassword() async {
    return bool.parse(await pref.read(key: hasResetPasswordKey) ?? 'false');
  }

  /// To save if all goals are provided by the user to cache. Pass `bool`
  Future setAllGoalsProvided(bool val) async {
    await pref.write(key: allGoalsProvidedKey, value: val.toString());
  }

  /// To fetch if all goals are provided by the user from cache. Returns `bool?`
  Future<bool> getAllGoalsProvided() async {
    return bool.parse(await pref.read(key: allGoalsProvidedKey) ?? 'false');
  }

  /// To save user's details to cache. Pass `UserCachedModel`
  Future setUserDetails(UserCachedModel details) async {
    await pref.write(key: userDetailsKey, value: jsonEncode(details.toJSON()));
  }

  /// To fetch user's details from cache. Returns `UserCachedModel?`
  Future<UserCachedModel?> getUserDetails() async {
    String? raw = await pref.read(key: userDetailsKey);
    if (raw == null || raw.isEmpty) return null;
    return UserCachedModel.fromJSON(jsonDecode(raw));
  }

  /// To save if user has selected dark mode. Pass `bool`
  Future setIsDarkMode(bool val) async {
    await pref.write(key: isDarkModeKey, value: val.toString());
  }

  /// To fetch if user has selected dark mode from cache. Returns `bool?`
  Future<bool?> getIsDarkMode() async {
    String? boolRaw = await pref.read(key: isDarkModeKey);
    if (boolRaw == null) return null;
    return bool.parse(boolRaw);
  }

  // ===================================================
}
