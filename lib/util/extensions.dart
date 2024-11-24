import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

extension Texts on TextEditingController {
  String get trimmedText => text.trim();
}

extension Validations on String {
  bool get isEmailValid => RegExp(
        r'^(([^<>()[\\.,;:\s@"]+([^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}[0-9]{1,3}[0-9]{1,3}\])|(([a-zA-Z\-0-9]+)+[a-zA-Z]{2,}))$',
      ).hasMatch(this);

  bool get isPasswordValid => RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
      ).hasMatch(this);

  bool get isPhoneValid => RegExp(r'^[0-9]{6,16}$').hasMatch(this);

  bool returnBool(String? value) {
    return value == null;
  }

  String capitalize() {
    List<String> words = split(' ');
    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = '${words[i][0].toUpperCase()}${words[i].substring(1)}';
      }
    }
    return words.join(' ');
  }
}

extension CustomizeString on String {
  String get removeCircularBrackets => replaceAll('(', '').replaceAll(')', '');
}

extension StringFunctions on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  String get orEmpty => this ?? "";

  String appendCount(num? count) {
    var title = this ?? '';
    if (count != null && count > 0) {
      title += " (${NumberFormat("00").format(count)})";
    }
    return title;
  }
}


extension WidgetExtensions on Widget {
  Widget addOnTap(VoidCallback? callback) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        if (!isRedundantClick(DateTime.now())) {
          HapticFeedback.mediumImpact();
          callback?.call();
        }
      },
      child: this,
    );
  }

  Expanded get expanded => Expanded(child: this);

  Widget visibility({required bool isVisible}) {
    return Visibility(
      visible: isVisible,
      child: this,
    );
  }

  Widget addPaddingAll(double value) {
    return Padding(
      padding: EdgeInsets.all(value),
      child: this,
    );
  }

  Widget addPadding({required EdgeInsetsGeometry padding}) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
  Widget addPaddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,}) {

    return Padding(
      padding: EdgeInsets.only(left: left, right: right, top: top, bottom: bottom),
      child: this,
    );
  }
}

DateTime? firstClickTime;

bool isRedundantClick(DateTime clickTime) {
  if (firstClickTime == null) {
    firstClickTime = clickTime;
    return false;
  }
  if (clickTime.difference(firstClickTime!).inMilliseconds < 400) {
    return true;
  }

  firstClickTime = clickTime;
  return false;
}

extension ScrollControllerUtil on ScrollController {
  bool isLoadMore() {
    return position.maxScrollExtent == position.pixels;
  }
}

extension ListUtil<E> on List<E> {
  List<E> append(E item) {
    var mList = this;
    mList.add(item);
    return mList;
  }
}

extension WidgetListUtil<Widget> on List<Widget> {
  List<Widget> divider(Widget item) {
    List<Widget> mList = [];
    for (var i = 0; i < length; i++) {
      mList.add(this[i]);
      if (i < length - 1) {
        mList.add(item);
      }
    }
    return mList;
  }
}

extension CrossAxisAlignmentUtil on String? {
  CrossAxisAlignment toCrossAxisAlignment() {
    switch (this) {
      case "left":
      case "start":
        return CrossAxisAlignment.start;
      case "right":
        return CrossAxisAlignment.end;
      case "end":
        return CrossAxisAlignment.end;
      case "center":
        return CrossAxisAlignment.center;
      default:
        return CrossAxisAlignment.center;
    }
  }
}

extension TextAlignUtil on String? {
  TextAlign toTextAlign() {
    switch (this) {
      case "left":
        return TextAlign.left;
      case "start":
        return TextAlign.start;
      case "right":
        return TextAlign.right;
      case "end":
        return TextAlign.end;
      case "center":
        return TextAlign.center;
      default:
        return TextAlign.center;
    }
  }
}
