import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fixbuddy/app/utils/extensions.dart';

class AppConstants {
  ///no. of days after which fcm token will be updated - 7
  static const int fcmTokenCheckDaysBuffer = 7;
  //data limits
  static const int durationPickerHourLimit = 6; //6 hours
  static const int durationPickerMinutesLimit = 59; //59 minutes

  //links
  static const String termsAndConditions = 'https://www.google.com';
  static const String privacyPolicyLink = 'https://serwex.in/privacy';

  static const String supportEmail = 'support@thelifetrackr.com';

  //deep links
  static const String deepLink = 'https://serwex.in';
  // allowed extensions
  static const List<String> allowedImageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.webp',
  ];

  static const List<String> allowedVideoExtensions = [
    '.mp4',
    '.mov',
    '.avi',
    '.mkv',
  ];

  static const int maxVideoLength = 30; //30 seconds

  static String androidAppLink =
      "https://play.google.com/store/apps/details?id=com.life.trackr&hl=en";
  static String iosAppLink =
      "https://apps.apple.com/in/app/the-life-trackr/id6740070195";
  static String get appLink => Platform.isAndroid ? androidAppLink : iosAppLink;
  static String shareLink = '\n Android: $androidAppLink\nIOS: $iosAppLink';

  static String learningCategoryId = 'Sf/d8lNqpYg+7fanEq/KLA==';

  static const String pedometerPrefKey = 'lifetrackr_pedometer_key';
}

// enum to handle app's language
enum AppLanguage {
  hindi('hi'),
  english('en');

  const AppLanguage(this.locale);

  final String locale;

  static bool isEnglish(BuildContext context) {
    return context.l10n.localeName == AppLanguage.english.locale;
  }

  static bool isHindi(BuildContext context) {
    return context.l10n.localeName == AppLanguage.hindi.locale;
  }
}

// enum to handle gender accross the app
enum Gender {
  male('Male', 'पुरुष', 1),
  female('Female', 'महिला', 2),
  others('Others', 'अन्य', 3);

  const Gender(this.name, this.nameHindi, this.value);

  final String name;
  final String nameHindi;
  final int value;

  String getName() {
    bool isEnglish = Get.context!.isEnglishLocale;
    return isEnglish ? name : nameHindi;
  }

  static Gender fromValue(int value) {
    return switch (value) {
      1 => Gender.male,
      2 => Gender.female,
      _ => Gender.others,
    };
  }

  static Gender fromName(String name) {
    return switch (name) {
      'Male' => Gender.male,
      'Female' => Gender.female,
      'पुरुष' => Gender.male,
      'महिला' => Gender.female,
      _ => Gender.others,
    };
  }
}

enum PickerFileType { image, video }

enum StepsPreference {
  pedometer('pedometer'),
  health('health'),
  manual('manual');

  const StepsPreference(this.name);

  final String name;

  static StepsPreference fromName(String n) {
    return switch (n) {
      'pedometer' => StepsPreference.pedometer,
      'health' => StepsPreference.health,
      'manual' => StepsPreference.manual,
      _ =>
        Platform.isAndroid ? StepsPreference.pedometer : StepsPreference.health,
    };
  }
}

class ContentConstants {
  static const String communityGuidelines =
      r"""Health Parliament is a platform where; 

1. Users indulge in meaningful, solution centric discussions and respect different opinions and perspectives. 

2. Users should be respectful and courteous while responding to comments, even while having a disagreement on a topic/ opinion/comment/ question. 

3. Posts should only be related to all the domains under healthcare & medical science. Refrain from posting unrelated content/comments. 

4. Posting any of the below mentioned content will result in immediate blocking and deactivation of your account from admin end: 

a. Use of abusive/offensive language AND/OR content. 

b. Product or Service promotion of any kind. 

c. Being disrespectful towards a fellow user. 

d. If your content is reported more than 3 times by other users. 

e. Spreading misinformation OR/ AND unverified/unscientific information. 

f. Revealing personal information of other users. 

g. Racist or casteist slurs. 

h. Harassment and bullying of any nature. 

i. Threat of violence to any user 

j. Promotion of hate based on identity or vulnerability of any community. 

k. Sexually explicit content Posting illegal content or soliciting or facilitating illegal or prohibited transactions. 

5. Do not share, seek or reveal your/ others personal details like email mobile number, etc. with others on this app or any external medium nature. 

6. Refrain from posting routine greetings and forwarded messages on the app 

7. Don't impersonate an individual or an entity in a misleading or deceptive manner. 

Note: The word Content in the document has under its purview - written posts; video posts; pictures, or any other means of communication. """;
}

Map timezoneNames = {
  0: 'UTC',
  10800000: 'Indian/Mayotte',
  3600000: 'Europe/London',
  7200000: 'Europe/Zurich',
  -32400000: 'Pacific/Gambier',
  -28800000: 'US/Alaska',
  -14400000: 'US/Eastern',
  -10800000: 'Canada/Atlantic',
  -18000000: 'US/Central',
  -21600000: 'US/Mountain',
  -25200000: 'US/Pacific',
  -7200000: 'Atlantic/South_Georgia',
  -9000000: 'Canada/Newfoundland',
  39600000: 'Pacific/Pohnpei',
  25200000: 'Indian/Christmas',
  36000000: 'Pacific/Saipan',
  18000000: 'Indian/Maldives',
  46800000: 'Pacific/Tongatapu',
  21600000: 'Indian/Chagos',
  43200000: 'Pacific/Wallis',
  14400000: 'Indian/Reunion',
  28800000: 'Australia/Perth',
  32400000: 'Pacific/Palau',
  19800000: 'Asia/Kolkata',
  16200000: 'Asia/Kabul',
  20700000: 'Asia/Kathmandu',
  23400000: 'Indian/Cocos',
  12600000: 'Asia/Tehran',
  -3600000: 'Atlantic/Cape_Verde',
  37800000: 'Australia/Broken_Hill',
  34200000: 'Australia/Darwin',
  31500000: 'Australia/Eucla',
  49500000: 'Pacific/Chatham',
  -36000000: 'US/Hawaii',
  50400000: 'Pacific/Kiritimati',
  -34200000: 'Pacific/Marquesas',
  -39600000: 'Pacific/Pago_Pago',
};
