import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/data/di/locator.dart';

class MiscService {
  void getFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  }

  void revertFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
  }

  // Future<PackageInfo> _getPackageInfo() async {
  //   return await PackageInfo.fromPlatform();
  // }
  //
  // Future<String> getAppVersion() async {
  //   var packageInfo = await _getPackageInfo();
  //   return packageInfo.version;
  // }

  void closeKeyboard() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void unFocusField() {
    FocusScope.of(appContext).requestFocus(FocusNode());
  }

  Color hexToColor(String? hexColor) {
    hexColor ??= '#E0E0E0';
    if (hexColor.startsWith('#')) {
      hexColor = hexColor.substring(1);
    }
    int hexValue = int.parse(hexColor, radix: 16);
    return Color(hexValue | 0xFF000000);
  }
}
