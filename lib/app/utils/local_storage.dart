import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fixbuddy/app/data/models/user_cached_model.dart';

class LocalStorage {
  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  late FlutterSecureStorage pref;

  LocalStorage() {
    pref = FlutterSecureStorage(aOptions: _getAndroidOptions());
  }

  // === Keys ===

  // Secure storage keys
  final String tokenKey = 'tokenKey';
  final String firebaseTokenKey = 'firebaseTokenKey';
  final String userIDKey = 'userIDKey';
  final String lastLoginDateKey = 'lastLoginDateKey';
  final String userLanguageKey = 'userLanguageKey';
  final String lastFCMUpdatedAtKey = 'lastFCMUpdatedAtKey';
  final String lastSentFCMKey = 'lastSentFCMKey';
  final String hasResetPasswordKey = 'hasResetPasswordKey';
  final String allGoalsProvidedKey = 'allGoalsProvidedKey';
  final String userDetailsKey = 'userDetailsKey';
  final String isDarkModeKey = 'isDarkModeKey';

  // Additional data
  final String reminderPreferenceKey = 'reminderPreferenceKey';
  final String preferredCalIdKey = 'preferredCalIdKey';
  final String addedCalendarEventIdKey = 'addedCalendarEventIdKey';
  final String addedRemindersKey = 'addedRemindersKey';

  final String homeDataKey = 'homeDataKey';
  final String lastHomeDataFetchedAtKey = 'lastHomeDataFetchedAtKey';
  final String lastStepsUpdatedAtKey = 'lastStepsUpdatedAtKey';
  final String lastAssessmentRemindedAtKey = 'lastAssessmentRemindedAtKey';
  final String userOptedForManualStepsKey = 'userOptedForManualStepsKey';
  final String hasFetchedStepsProgressTodayKey =
      'hasFetchedStepsProgressTodayKey';
  final String stepsProgressTrackingKey = 'stepsProgressTrackingKey';
  final String userBadgesKey = 'userBadgesKey';

  final String communityDataKey = 'communityDataKey';
  final String userBuddiesKey = 'userBuddiesKey';
  final String userSentBuddyRequestsKey = 'userSentBuddyRequestsKey';

  final String hasIOSHealthPermissionKey = 'hasIOSHealthPermissionKey';
  final String lastAssessedAtKey = 'lastAssessedAtKey';
  static const String userProfile = "MyProfile";
  final String stepsDataKey = 'stepsDataKey';
  final String stepsPreferenceKey = 'stepsPreferenceKey';

  // SharedPreferences keys
  final String sharedPrefOnboardedKey = 'user_onboarded';
  final String registrationStatusKey = 'registrationStatusKey';
  final String lastRegistrationUpdatedKey = 'lastRegistrationUpdatedKey';

  // === General Methods ===

  Future<void> clearLocalStorage() async {
    String? prevLang = await getLanguage();
    bool? prevIsDarkMode = await getIsDarkMode();

    await pref.deleteAll(aOptions: _getAndroidOptions());

    if (prevLang != null) await setLanguage(prevLang);
    if (prevIsDarkMode != null) await setIsDarkMode(prevIsDarkMode);
  }

  // === Token ===

  Future<void> setToken(String val) async {
    await pref.write(key: tokenKey, value: val);
  }

  Future<String?> getToken() async {
    return await pref.read(key: tokenKey);
  }

  Future<void> setFirebaseToken(String val) async {
    await pref.write(key: firebaseTokenKey, value: val);
  }

  Future<String?> getFirebaseToken() async {
    return await pref.read(key: firebaseTokenKey);
  }

  // === User Info ===

  Future<void> setUserID(int val) async {
    await pref.write(key: userIDKey, value: val.toString());
  }

  Future<int?> getUserID() async {
    String? userIdString = await pref.read(key: userIDKey);
    return userIdString != null ? int.tryParse(userIdString) : null;
  }

  Future<void> setUserDetails(UserCachedModel details) async {
    await pref.write(key: userDetailsKey, value: jsonEncode(details.toJSON()));
  }

  Future<UserCachedModel?> getUserDetails() async {
    String? raw = await pref.read(key: userDetailsKey);
    if (raw == null || raw.isEmpty) return null;
    return UserCachedModel.fromJSON(jsonDecode(raw));
  }

  // === Dates ===

  Future<void> setLastLoginDate(DateTime val) async {
    await pref.write(key: lastLoginDateKey, value: val.toIso8601String());
  }

  Future<DateTime?> getLastLoginDate() async {
    String? dateStr = await pref.read(key: lastLoginDateKey);
    return dateStr != null ? DateTime.tryParse(dateStr) : null;
  }

  Future<void> setLastFCMUpdatedAtDate(DateTime val) async {
    await pref.write(key: lastFCMUpdatedAtKey, value: val.toIso8601String());
  }

  Future<DateTime?> getLastFCMUpdatedAtDate() async {
    String? dateStr = await pref.read(key: lastFCMUpdatedAtKey);
    return dateStr != null ? DateTime.tryParse(dateStr) : null;
  }

  // === Preferences ===

  Future<void> setLanguage(String val) async {
    await pref.write(key: userLanguageKey, value: val);
  }

  Future<String?> getLanguage() async {
    return await pref.read(key: userLanguageKey);
  }

  Future<void> setIsDarkMode(bool val) async {
    await pref.write(key: isDarkModeKey, value: val.toString());
  }

  Future<bool?> getIsDarkMode() async {
    String? val = await pref.read(key: isDarkModeKey);
    return val != null ? bool.tryParse(val) : null;
  }

  // === Flags ===

  Future<void> setHasResetPassword(bool val) async {
    await pref.write(key: hasResetPasswordKey, value: val.toString());
  }

  Future<bool> getHasResetPassword() async {
    return bool.parse(await pref.read(key: hasResetPasswordKey) ?? 'false');
  }

  Future<void> setAllGoalsProvided(bool val) async {
    await pref.write(key: allGoalsProvidedKey, value: val.toString());
  }

  Future<bool> getAllGoalsProvided() async {
    return bool.parse(await pref.read(key: allGoalsProvidedKey) ?? 'false');
  }

  // === Onboarding & Registration (SharedPreferences) ===

  Future<void> setUserOnboarded(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(sharedPrefOnboardedKey, value);
  }

  Future<bool> getUserOboarded() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPrefOnboardedKey) ?? false;
  }

  Future<void> setRegistrationStatus(int status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(registrationStatusKey, status);
  }

  Future<int> getRegistrationStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(registrationStatusKey) ?? 0;
  }

  Future<void> setLastRegisteredDate(DateTime date) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(lastRegistrationUpdatedKey, date.toIso8601String());
  }

  Future<String> getLastRegisteredDate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(lastRegistrationUpdatedKey) ??
        '2001-01-01 00:00:00.000';
  }

  // === Generic Storage Helpers ===

  void saveDataToLocal(String key, String data) {
    pref.write(key: key, value: data, aOptions: _getAndroidOptions());
  }

  Future<Map> getMapDataFromLocal(String key) async {
    String data = await pref.read(key: key, aOptions: _getAndroidOptions()) ?? "{}";
    return json.decode(data);
  }

  Future<List> getListDataFromLocal(String key) async {
    String data = await pref.read(key: key, aOptions: _getAndroidOptions()) ?? "[]";
    return json.decode(data);
  }

  Future<void> setLastSentFCM(String val) async {
    await pref.write(key: lastSentFCMKey, value: val);
  }

  Future<String?> getLastSentFCM() async {
    return await pref.read(key: lastSentFCMKey);
  }
}
