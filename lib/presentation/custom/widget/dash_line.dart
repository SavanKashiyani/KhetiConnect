import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

class SeparatorLine extends StatelessWidget {
  const SeparatorLine({
    Key? key,
    this.thickness = 1,
    this.color = ColorName.black,
    this.dashLength = 5,
    this.spaceBetween = 3,
    this.direction = Axis.horizontal,
  }) : super(key: key);

  final double thickness;
  final Color color;
  final double dashLength;
  final double spaceBetween;
  final Axis direction;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isHorizontal = direction == Axis.horizontal;
        final lineLength = isHorizontal
            ? constraints.constrainWidth()
            : constraints.constrainHeight();

        // Calculate dash count, ensuring it's at least 1 and handling potential division by zero
        final dashCount = (dashLength + spaceBetween) > 0
            ? ((lineLength / (dashLength + spaceBetween)).floor()).clamp(1, double.infinity).toInt()
            : 1;

        return Flex(
          direction: direction,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: isHorizontal ? dashLength : thickness,
              height: isHorizontal ? thickness : dashLength,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}