import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

Widget addHeight(double? height) {
  return SizedBox(height: height);
}

Widget addWidth(double? width) {
  return SizedBox(width: width);
}

//return divider
Widget divider() {
  return const Divider(
    color: ColorName.gray100,
    height: 1,
  );
}
