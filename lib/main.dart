import 'dart:io';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fixbuddy/app/constants/app_constants.dart';
import 'package:fixbuddy/app/l10n/app_localizations.dart';
import 'package:fixbuddy/app/utils/deep_link.dart';
import 'package:fixbuddy/app/utils/local_storage.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'app/routes/app_pages.dart';
import 'app/utils/firebase_notifications.dart';
import 'app/utils/local_notifications.dart';
import 'app/utils/servex_utils.dart';
import 'firebase_options.dart';

/// In-app Theme Mode
Rx<ThemeMode> appThemeMode = ThemeMode.system.obs;

/// AppMode Enum (Optional — can be removed if not needed)
enum AppMode { dev, test, live }

AppMode currentAppMode = AppMode.live;

/// Background message handler
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServexUtils.logPrint(
    '---> Background message: ${message.notification?.title}',
  );
}

LocalStorage localStorage = LocalStorage();
bool isLoggedIn = false;
String updateType = 'flexible';
DateTime? currentBackPressTime;
RemoteMessage? initialFMessage;
NotificationResponse? initialLocalNotification;
late DeepLink deepLink;
// Rx<ThemeMode> appThemeMode = ThemeMode.dark.obs;

bool hasAlreadyAskedForHealthPermissions = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Analytics in Release + Live only
  FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(
    kReleaseMode && currentAppMode == AppMode.live,
  );

  // Initialize local notifications
  await FlutterLocalNotificationsPlugin().initialize(
    LocalNotifications.initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      LocalNotifications.onSelectNotification(details);
    },
  );

  // Initialize timezone package
  tz.initializeTimeZones();

  // Orientation lock
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Ask for notification permissions
  await Permission.notification.isDenied.then((value) {
    if (value) Permission.notification.request();
  });

  // iOS FCM Permission
  if (Platform.isIOS) {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          badge: true,
          sound: true,
          criticalAlert: true,
        );
    ServexUtils.logPrint(
      'Notification permission: ${settings.authorizationStatus}',
    );
  }

  // Log FCM Token for debugging
  String? token = await FirebaseMessaging.instance.getToken();
  ServexUtils.logPrint('FCM Token: $token');

  // Setup background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  runApp(const ServexApp());
}

class ServexApp extends StatefulWidget {
  const ServexApp({super.key});

  @override
  State<ServexApp> createState() => _ServexAppState();
  static void setLocale(BuildContext context, Locale newLocale) {
    _ServexAppState? state = context.findAncestorStateOfType<_ServexAppState>();
    state?.setLocale(newLocale);
  }

  static void setThemeMode(BuildContext context, ThemeMode theme) {
    _ServexAppState? state = context.findAncestorStateOfType<_ServexAppState>();
    state?.setThemeMode(theme);
  }
}

class _ServexAppState extends State<ServexApp> with WidgetsBindingObserver {
  Locale? _locale;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      String lang =
          await LocalStorage().getLanguage() ?? AppLanguage.english.locale;
      setState(() {
        _locale = Locale(lang, '');
      });

      bool? isDarkMode = await LocalStorage().getIsDarkMode();
      setState(() {
        if (isDarkMode != null) {
          appThemeMode.value = isDarkMode ? ThemeMode.dark : ThemeMode.light;
        }
      });
    });

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    // Setup Firebase notification listeners
    FirebaseNotifications().notificationListeners();

    // Check for terminated notifications
    LocalNotifications.getTerminatedTapLaunchDetails();
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setThemeMode(ThemeMode theme) {
    setState(() {
      appThemeMode.value = theme;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!isLoggedIn) return;
    super.didChangeAppLifecycleState(state);
    // check the notification count whenever Applifecyclestate changes
    switch (state) {
      case AppLifecycleState.inactive:
        ServexUtils.dPrint("--->app state: inactive");
        // FirebaseNotifications().notificationCountGetter();
        break;
      case AppLifecycleState.resumed:
        ServexUtils.dPrint("--->app state: resumed");
        // FirebaseNotifications().notificationCountGetter();
        break;
      case AppLifecycleState.paused:
        ServexUtils.dPrint("--->app state: paused");
        // FirebaseNotifications().notificationCountGetter();
        break;
      case AppLifecycleState.detached:
        ServexUtils.dPrint("--->app state: detached");
        break;
      default:
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 834),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        title: "Servex",
        debugShowCheckedModeBanner: currentAppMode != AppMode.live,
        locale: _locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppPages.initial,
        getPages: AppPages.routes,
        themeMode: appThemeMode.value,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
      ),
    );
  }
}
