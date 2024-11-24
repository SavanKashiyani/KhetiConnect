import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Widget child;
  final RefreshCallback onRefresh;

  const CustomProgressIndicator(
      {super.key, required this.child, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      backgroundColor: ColorName.primary,
      color: ColorName.white,
      child: child,
    );
  }
}
