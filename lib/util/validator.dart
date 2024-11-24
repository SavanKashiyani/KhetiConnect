import '/util/validation_regex.dart';

class Validator {
  static bool isEmail(String value) => value.contains('@');

  static String? validateEmailOrPhone(
    String? value,
  ) {
    if (value == null || value.isEmpty) {
      return '';
    } else if (value.contains('@')) {
      if (!ValidationRegex.emailRegexForValidation.value.hasMatch(value)) {
        return '';
      }
    } else {
      if (!ValidationRegex.phoneRegex.value.hasMatch(value)) {
        return '';
      }
    }
    return null;
  }

  static String? isEmailValidate(String? value) {
    if (!ValidationRegex.emailRegexForValidation.value.hasMatch(value!)) {
      return '';
    }
    return null;
  }

  static String? isMobileValidate(String? value) {
    if (!ValidationRegex.phoneRegex.value.hasMatch(value!)) {
      return '';
    }
    return null;
  }

  static String? isDescriptionValidate(String? value) {
    if (!ValidationRegex.descriptionRegex.value.hasMatch(value!.trim())) {
      return '';
    }
    return null;
  }

  static String? isNowEmpty(String? value) {
    if (value!.trim().isEmpty) {
      return '';
    }
    return null;
  }

  static String? validateRequired(String? value,String message) {
    if (value!=null && value.trim().isEmpty) {
      return message;
    } else {
      return null;
    }
  }
}
