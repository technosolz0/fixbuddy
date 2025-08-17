// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class FAnalytics {
  // //events
  // static const String discussinoSessions = 'discussion_sessions';
  // static const String pdfSessions = 'pdf_sessions';
  // static const String discussionExpanded = 'discussion_expanded';
  // static const String accDeletionRequest = 'acc_deletion_request';
  // static const String appUserSubscribed = 'app_user_subscribed';

  // //user properties
  // static const String userGender = 'user_gender';
  // static const String userCurrentStatus = 'user_current_status';
  // static const String userPaid = 'user_paid';
  // static const String userCategory = 'user_category';
  // static const String userLevel = 'user_level';

  // static void logAppUserSubscribed(
  //     {required double amount, required String currency}) {
  //   if (kDebugMode || currentAppMode == AppMode.test) return;
  //   Utilities.dPrint('-->logging app user subscribed');
  //   FirebaseAnalytics.instance.logEvent(name: appUserSubscribed, parameters: {
  //     'app_user_subscription_amount': amount,
  //     'app_user_subscription_currency': currency,
  //   });
  //   FirebaseAnalytics.instance.logPurchase(
  //     currency: currency,
  //     value: amount,
  //   );
  // }

  // static void logDiscussionExpanded({required String title}) {
  //   if (kDebugMode || currentAppMode == AppMode.test) return;
  //   Utilities.dPrint('-->logging discussion expanded');
  //   FirebaseAnalytics.instance.logEvent(name: discussionExpanded, parameters: {
  //     'discussion_expanded_title': title,
  //   });
  // }

  // static void logAccountDeletionRequest({required String reason}) {
  //   if (kDebugMode || currentAppMode == AppMode.test) return;
  //   Utilities.dPrint('-->logging account deletion request');
  //   FirebaseAnalytics.instance.logEvent(name: accDeletionRequest, parameters: {
  //     'acc_deletion_reason': reason,
  //   });
  // }

  // static void logDiscussionScreenSeconds(
  //     {required String title, required int seconds}) {
  //   if (kDebugMode || currentAppMode == AppMode.test) return;
  //   Utilities.dPrint('-->logging discussion session');
  //   FirebaseAnalytics.instance.logEvent(name: discussinoSessions, parameters: {
  //     'discussion_session_title': title,
  //     'discussion_session_length': seconds,
  //   });
  // }

  // static void logPDFScreenSeconds(
  //     {required String title, required int seconds}) {
  //   if (kDebugMode || currentAppMode == AppMode.test) return;
  //   Utilities.dPrint('-->logging pdf session');
  //   FirebaseAnalytics.instance.logEvent(name: pdfSessions, parameters: {
  //     'pdf_session_title': title,
  //     'pdf_session_length': seconds,
  //   });
  // }

  // static void logScreen({String? screenClass, String? screenName}) async {
  //   WidgetsBinding.instance.addPostFrameCallback(
  //     (timeStamp) {
  //       FirebaseAnalytics.instance.logScreenView(
  //         screenClass: screenClass,
  //         screenName: screenName,
  //       );
  //     },
  //   );
  // }
// }
