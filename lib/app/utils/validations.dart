import 'package:get/get.dart';
import 'package:fixbuddy/app/utils/extensions.dart';

class Validator {
  /// Checks for null and empty empty values. Pass `String` name and `String` value
  static String? emptyValidation(String name, String? val) {
    if (val == null || val.trim().isEmpty) {
      return '$name ${Get.context!.l10n.cannot_be_empty}';
    }
    return null;
  }

  /// Email validation. Pass `String`
  ///
  /// Checks for null and empty value
  ///
  /// Checks for proper email format using regexp
  static String? emailValidation(String? email) {
    if (email == null || email.trim().isEmpty) {
      return '${Get.context!.l10n.email} ${Get.context!.l10n.cannot_be_empty}.';
    }
    final emailRegExp = RegExp(
      r"[a-zA-Z0-9_.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9_.!#$%&'*+/=?^_`{|}~-]+\.[a-zA-Z]+",
    );
    if (!emailRegExp.hasMatch(email)) {
      return '${Get.context!.l10n.email} ${Get.context!.l10n.is_invalid}';
    }
    return null;
  }

  /// Phone validation. Pass `String` name and `String` phone
  ///
  /// Checks for null and empty value
  ///
  /// Checks for length of value between 8 and 10, both non-inclusive
  static String? phoneValidation(String? name, String? phone) {
    if (phone == null || phone.trim().isEmpty) {
      return '${name ?? Get.context!.l10n.mobile_number} ${Get.context!.l10n.cannot_be_empty}';
    }

    if (phone.length < 8 || phone.length > 15) {
      return Get.context!.l10n.enter_valid_number;
    }
    return null;
  }

  /// Password validation. Pass `String` password, option `String` confirm password
  ///
  /// Checks for null and empty password value
  ///
  /// Checks for value length for 8 characters
  ///
  /// If confirm password is passed, checks for matching of password and confirm password
  static String? passwordValidation(String? pass, {String? confirmPassword}) {
    if (pass == null || pass.trim().isEmpty) {
      return '${Get.context!.l10n.password} ${Get.context!.l10n.cannot_be_empty}';
    }
    if (pass.trim().length < 7 || pass.trim().length > 12) {
      return Get.context!.l10n.password_length_validation;
    }

    final passRegExp = RegExp(r'^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).+$');
    if (!passRegExp.hasMatch(pass)) {
      return Get.context!.l10n.password_character_validation;
    }

    if (confirmPassword != null && pass != confirmPassword.trim()) {
      return Get.context!.l10n.password_didnt_match;
    }
    return null;
  }

  /// Length validation. Pass `String` name, `int` number, `String` val
  ///
  /// Checks for null and empty value
  ///
  /// Checks for number of characters for given int number length
  static String? characterLengthValidation(
    String name,
    int number,
    String? val,
  ) {
    if (val == null || val.trim().isEmpty) {
      return '$name ${Get.context!.l10n.cannot_be_empty}';
    }

    if (val.trim().length < number) {
      return '$name ${Get.context!.l10n.is_invalid}.';
    }
    return null;
  }
}
