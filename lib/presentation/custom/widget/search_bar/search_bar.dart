import 'package:flutter/material.dart';
import 'package:kheticonnect/util/extensions.dart';

import '../../../../core/app_export.dart';
import '../button/custom_icon_button.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isDisabled;
  final TextEditingController? controller;
  final Function()? onFilterClick;
  final FocusNode? focusNode;
  final String? hint;
  final Function(String)? onChanged;

  final bool isFilterApplied;
  final bool showFilter;

  const CustomSearchBar({
    super.key,
    this.isDisabled = false,
    this.controller,
    this.onFilterClick,
    this.focusNode,
    this.hint,
    this.onChanged,
    this.isFilterApplied = false,
    this.showFilter = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: IgnorePointer(
            ignoring: isDisabled,
            child: CustomTextField(
              controller: controller,
              isDisabled: isDisabled,
              focusNode: focusNode,
              onChanged: onChanged,
              hintText: hint ?? Strings.searchHint(),
              textInputAction: TextInputAction.done,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              borderDecoration: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(8),
              ),
              prefix: Assets.drawables.icSearch.svg(height: 24, width: 24),
            ),
          ),
        ),
        if(showFilter)
        Row(
          children: [
            SizedBox(width: 12.h),
            Stack(
              alignment: Alignment.topRight,
              children: [
                CustomIconButton(
                  height: 48.adaptSize,
                  width: 48.adaptSize,
                  padding: EdgeInsets.all(12.h),
                  decoration: IconButtonStyleHelper.fillPrimary,
                  child: Assets.drawables.icFilter.svg(),
                  onTap: () => onFilterClick?.call(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Assets.drawables.icRedDot.svg(height: 8, width: 8),
                ).visibility(isVisible: isFilterApplied)
              ],
            ),
          ],
        )
      ],
    );
  }
}
