import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';
import '../../../util/text_styles.dart';
import '../../../util/widget_util.dart';
import 'custom_checkbox_button.dart';
import 'custom_text.dart';


class TitledDropDown extends StatelessWidget {
  final String? title;
  final String hint;
  final String? selValue;
  final EdgeInsetsGeometry? padding;
  // final Function(String?)? onItemChanged;
  final bool? enabled;
  final List<String> items;
  final ValueChanged<String?>? onItemChanged;
  final double? minWidth;
  final double? minHeight;
  final bool isSmallDropDown;
  final bool isCheckboxList;
  final Function(bool)? onCheckChanged;
  final TextStyle? textStyle;
  final Color? backgroundColor;

  const TitledDropDown(
      {super.key,
      this.title,
      this.selValue,
      this.padding,
      this.onItemChanged,
      this.enabled,
      this.minWidth,
      this.minHeight,
      required this.items,
      required this.hint,
      this.isSmallDropDown = false,
      this.isCheckboxList = false,
      this.onCheckChanged,
      this.textStyle,
      this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return isSmallDropDown
        ? renderDropDown()
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
      children: [
              if (title != null)
                Text(title!,
                    style: TextStyles.jakarta.medium.of(
                      14,
                      color: ColorName.gray700,
                      fontWeight: FontWeight.w500,
            )),
        addHeight(8),
              renderDropDown(),
            ],
    );
  }

  getDropDownMenuItems(BuildContext context,List<String> items) {
    List<DropdownMenuItem> _items = [];
    for(int index=0;index<items.length;index++){
      _items.add(DropdownMenuItem(
          value: index as dynamic,
          child: CustomText(
              text: items[index], style: TextStyles.jakarta.medium.of(14,color: ColorName.primary,fontWeight: FontWeight.w500,))));
    }
    return _items;
  }

  renderDropDown() {
    return Container(
      width: minWidth,
      height: minHeight,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          border: Border.all(
            color: ColorName.primary50,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: selValue,
          underline: Container(),
          hint: CustomText(
              text: hint,
              style: TextStyles.jakarta.medium.of(
                14,
                color: ColorName.gray500,
                fontWeight: FontWeight.w500,
              )),
          icon: Assets.images.imgArrowdown.svg(),
          isExpanded: true,
          borderRadius: BorderRadius.circular(4.w),
          dropdownColor: ColorName.white,

          padding: EdgeInsets.only(right: 2.w,left: 3, top: 3, bottom: 3),
          items: items.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem(
                value: value,
                child: isCheckboxList
                    ? _renderCheckBoxRow(value)
                    : CustomText(
                        text: value,
                        style: textStyle ?? TextStyles.jakarta.medium.of(
                          14,
                          color: ColorName.primary,
                          fontWeight: FontWeight.w500,
                        )));
          }).toList(),
          onChanged: onItemChanged,
        ),
      ),
    );
  }

  _renderCheckBoxRow(String value) {
    return CustomCheckboxButton(
      text: value,
      textStyle: TextStyles.jakarta.medium.of(14, color: ColorName.gray500),
      value: false,
      onChange: (value) {
        if(onCheckChanged!=null) {
          onCheckChanged!(value);
        }
      },
    );
  }
}
