import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:fixbuddy/app/constants/app_constants.dart';
import 'package:fixbuddy/app/l10n/app_localizations.dart';

/// Localizatoin extension
/// access by context.l10n
extension BuildContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  bool get isLightTheme => Theme.of(this).brightness == Brightness.light;

  bool get isDarkTheme => Theme.of(this).brightness == Brightness.dark;
}

extension EnglishBuildContext on BuildContext {
  bool get isEnglishLocale => AppLanguage.isEnglish(this);
}

extension HindiBuildContext on BuildContext {
  bool get isHindiLocale => AppLanguage.isHindi(this);
}

extension StringExtension on String {
  /// String extension
  ///  To capitalize the string
  String toCapitalized() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// String extension
  /// To capitalize all words of the string
  String toProperCase() {
    if (isEmpty) return '';
    List<String> words = split(' ');
    for (int i = 0; i < words.length; i++) {
      words[i] = words[i].toCapitalized();
    }
    return words.join(' ');
  }

  bool get isVideo =>
      AppConstants.allowedVideoExtensions.contains(p.extension(split('?')[0]));

  bool get isImage =>
      AppConstants.allowedImageExtensions.contains(p.extension(split('?')[0]));

  String removeTags() {
    List<String> s = split(' ');
    List<String> ans = [];
    for (int i = 0; i < s.length; i++) {
      String w = s[i];
      if (w.startsWith('@') && w.length > 1 && w.split(';').length >= 2) {
        if (w.split(';')[1].split(':').length > 1) {
          ans.add('${i == 0 ? '' : ' '}@${w.split(';')[1].split(':')[1]}');
        }
      } else {
        ans.add(w);
      }
    }
    return ans.join(' ');
  }
}

//extension on Map<String,dynamic>
extension MapSDExtension on Map<String, dynamic> {
  String get ofLang => this[Get.context!.l10n.localeName] ?? this['en'] ?? '';
  String get ofLangCapitalized =>
      this[Get.context!.l10n.localeName.toCapitalized()] ?? this['En'] ?? '';
}

//extension on List<CreatePostMedia>

//extension to check if File is a video file
extension FileExtension on File {
  bool get isVideo =>
      AppConstants.allowedVideoExtensions.contains(p.extension(path));

  bool get isImage =>
      AppConstants.allowedImageExtensions.contains(p.extension(path));
}

extension RxThemeModeExtension on Rx<ThemeMode> {
  bool get isLightTheme => value == ThemeMode.light;
  bool get isDarkTheme => value == ThemeMode.dark;
}

extension ThemeModeExtension on ThemeMode {
  bool get isLightTheme => this == ThemeMode.light;
  bool get isDarkTheme => this == ThemeMode.dark;
}
