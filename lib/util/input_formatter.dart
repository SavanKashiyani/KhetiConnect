import 'package:flutter/services.dart';
import '/util/validation_regex.dart';

class InputFormatter {
  static List<TextInputFormatter>? digitOnlyFormatter = [
    FilteringTextInputFormatter.digitsOnly,
  ];
  static List<TextInputFormatter>? decimalNumberFormatter = [
    FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
  ];

  static List<TextInputFormatter>? emailFormatter = [
    FilteringTextInputFormatter.allow(
      ValidationRegex.emailRegex.value,
    ),
  ];

  static List<TextInputFormatter>? nameFormatter = [
    FilteringTextInputFormatter.allow(
      ValidationRegex.alphabetWithSpace.value,
    ),
  ];
}
