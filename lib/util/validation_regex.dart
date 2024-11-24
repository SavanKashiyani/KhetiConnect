import '/util/app_const.dart';

enum ValidationRegex {
  alphabetWithSpace,
  alphabetWithAtTheRate,
  userNameRegex,
  userNameWithSpaceRegex,
  emailRegex,
  emailRegexForValidation,
  phoneRegex,
  descriptionRegex,
  passwordRegex,
}

extension ValidationRegexExtension on ValidationRegex {
  RegExp get value {
    switch (this) {
      case ValidationRegex.alphabetWithSpace:
        return RegExp('[a-z A-Z]');

      case ValidationRegex.alphabetWithAtTheRate:
        return RegExp('[a-zA-Z@]');

      case ValidationRegex.userNameRegex:
        return RegExp('[a-z_.0-9]');

      case ValidationRegex.userNameWithSpaceRegex:
        return RegExp('[a-zA-Z_.0-9 ]');

      case ValidationRegex.emailRegex:
        return RegExp('[a-zA-Z0-9@.]');

      case ValidationRegex.phoneRegex:
        return RegExp(
          r'^[0-9]{' +
              AppConst.phoneNumberMinLen.toString() +
              ',' +
              AppConst.phoneNumberLen.toString() +
              '}\$',
        );

      case ValidationRegex.emailRegexForValidation:
        return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        );
      case ValidationRegex.descriptionRegex:
        return RegExp('[a-zA-Z_.0-9 ]');
      case ValidationRegex.passwordRegex:
        return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$');
    }
  }
}
