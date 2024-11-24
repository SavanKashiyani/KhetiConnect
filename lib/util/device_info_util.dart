import 'package:flutter/material.dart';
import 'package:kheticonnect/data/di/locator.dart';

String getDeviceType() {
  final targetPlatform = Theme.of(appContext).platform;
  if (targetPlatform == TargetPlatform.android) {
    return "android";
  } else if (targetPlatform == TargetPlatform.iOS) {
    return "ios";
  } else {
    return targetPlatform.name;
  }
}
