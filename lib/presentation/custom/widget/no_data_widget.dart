import 'package:flutter/material.dart';
import 'package:kheticonnect/core/app_export.dart';

import '../../../util/text_styles.dart';

class NoDataWidget extends StatelessWidget {
  final String? title;
  final String? desc;
  final bool isScrollable;
  final bool shrinkWrap;
  final double? height;
  final double? width;

  const NoDataWidget(
      {super.key,
      this.title,
      this.desc, this.isScrollable = true, this.height,
        this.width,this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
          physics: isScrollable
              ? const AlwaysScrollableScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              constraints: shrinkWrap
                  ? null
                  : BoxConstraints(minHeight: constraints.maxHeight),
              padding: const EdgeInsets.only(left: 32, right: 32, bottom: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.drawables.icNoData.svg(width: 160, height: 120),
                  addHeight(16),
                  Text(
                    title ?? Strings.noDataFound(),
                    textAlign: TextAlign.center,
                    style:
                        TextStyles.exo.medium.of(18, color: ColorName.primary),
                  ),
                  addHeight(8),
                  Text(
                    desc ?? "",
                    textAlign: TextAlign.center,
                    style: TextStyles.jakarta.semiBold
                        .of(12, color: ColorName.gray600),
                  ),
                ],
              )));
    });
  }
}
