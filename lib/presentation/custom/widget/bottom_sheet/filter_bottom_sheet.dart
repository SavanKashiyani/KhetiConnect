import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/presentation/custom/widget/button/custom_button.dart';
import 'package:kheticonnect/presentation/service/navigation.dart';

import '../../../../data/enums/condition_type_enum.dart';
import '../../../../data/enums/product_type_enum.dart';
import '../../../../util/text_styles.dart';
import '../custom_checkbox_button.dart';
import 'bottom_sheet.dart';

showBSFilter({
  required List<ProductType>? selectedProductTypes,
  required List<ConditionType>? selectedConditionTypes,
  required Function(BSFilterState) onFilterChanged,
}) {
  getBottomSheet(title: Strings.filter(), children: [
    BSFilter(
      initialSelectedProductTypes: selectedProductTypes,
      initialSelectedConditionTypes: selectedConditionTypes,
      onFilterChanged: onFilterChanged,
    ),
  ]);
}

class BSFilter extends StatefulWidget {
  final List<ProductType>? initialSelectedProductTypes;
  final List<ConditionType>? initialSelectedConditionTypes;
  final Function(BSFilterState) onFilterChanged;

  const BSFilter({
    Key? key,
    this.initialSelectedProductTypes,
    this.initialSelectedConditionTypes,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  BSFilterState createState() => BSFilterState();
}

class BSFilterState extends State<BSFilter> {
  late Set<ProductType> selectedProductTypes;
  late Set<ConditionType> selectedConditionTypes;
  final navigation = GetIt.I<NavigationService>();

  @override
  void initState() {
    super.initState();
    selectedProductTypes = widget.initialSelectedProductTypes?.toSet() ?? {};
    selectedConditionTypes =
        widget.initialSelectedConditionTypes?.toSet() ?? {};
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.84),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._buildProductConditionWidget(),
            ..._buildProductTypeWidget(),
            addHeight(20),
            const Divider(height: 1, color: ColorName.primary100),
            addHeight(20),
            _buildButtonsWidget(),
            addHeight(20),
          ],
        ),
      ),
    );
  }

  _buildProductConditionWidget() {
    var textStyle = TextStyles.jakarta.medium.of(14, color: ColorName.gray600);
    var padding = const EdgeInsets.all(0);
    return [
      addHeight(28),
      Text(
        Strings.productCondition(),
        style: TextStyles.exo.medium.of(16, color: ColorName.primary),
      ),
      addHeight(8),
      Row(
        children: [
          CustomCheckboxButton(
            textStyle: textStyle,
            text: Strings.excellent(),
            padding: padding,
            value: selectedConditionTypes.contains(ConditionType.Excellent),
            onChange: (value) {
              if (value) {
                selectedConditionTypes.add(ConditionType.Excellent);
              } else {
                selectedConditionTypes.remove(ConditionType.Excellent);
              }
            },
          ),
          addWidth(16),
          CustomCheckboxButton(
            padding: padding,
            textStyle: textStyle,
            text: Strings.good(),
            value: selectedConditionTypes.contains(ConditionType.Good),
            onChange: (value) {
              if (value) {
                selectedConditionTypes.add(ConditionType.Good);
              } else {
                selectedConditionTypes.remove(ConditionType.Good);
              }
            },
          ),
          addWidth(16),
          CustomCheckboxButton(
            padding: padding,
            textStyle: textStyle,
            text: Strings.average(),
            value: selectedConditionTypes.contains(ConditionType.Average),
            onChange: (value) {
              if (value) {
                selectedConditionTypes.add(ConditionType.Average);
              } else {
                selectedConditionTypes.remove(ConditionType.Average);
              }
            },
          )
        ],
      )
    ];
  }

  _buildProductTypeWidget() {
    var textStyle = TextStyles.jakarta.medium.of(14, color: ColorName.gray600);
    var padding = const EdgeInsets.all(0);
    return [
      addHeight(28),
      Text(
        Strings.productType(),
        style: TextStyles.exo.medium.of(16, color: ColorName.primary),
      ),
      addHeight(8),
      Row(
        children: [
          CustomCheckboxButton(
            textStyle: textStyle,
            text: Strings.productTypeNew(),
            padding: padding,
            value: selectedProductTypes.contains(ProductType.New),
            onChange: (value) {
              if (value) {
                selectedProductTypes.add(ProductType.New);
              } else {
                selectedProductTypes.remove(ProductType.New);
              }
            },
          ),
          addWidth(16),
          CustomCheckboxButton(
            padding: padding,
            textStyle: textStyle,
            text: Strings.productTypeOld(),
            value: selectedProductTypes.contains(ProductType.Old),
            onChange: (value) {
              if (value) {
                selectedProductTypes.add(ProductType.Old);
              } else {
                selectedProductTypes.remove(ProductType.Old);
              }
            },
          ),
          addWidth(16),
          CustomCheckboxButton(
            padding: padding,
            textStyle: textStyle,
            text: Strings.productTypeVeryOld(),
            value: selectedProductTypes.contains(ProductType.VeryOld),
            onChange: (value) {
              if (value) {
                selectedProductTypes.add(ProductType.VeryOld);
              } else {
                selectedProductTypes.remove(ProductType.VeryOld);
              }
            },
          )
        ],
      )
    ];
  }

  _buildButtonsWidget() {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            isFilled: false,
            isEnabled: true,
            showMargin: false,
            style: TextStyles.jakarta.semiBold.of(16, color: ColorName.primary),
            buttonText: Strings.reset(),
            onClick: () {
              selectedProductTypes.clear();
              selectedConditionTypes.clear();
              widget.onFilterChanged(this);
              GetIt.I<NavigationService>().pop();
            },
          ),
        ),
        addWidth(16),
        Expanded(
          child: CustomButton(
            showMargin: false,
            style: TextStyles.jakarta.semiBold.of(16, color: ColorName.white),
            buttonText: Strings.apply(),
            onClick: () {
              widget.onFilterChanged(this);
              GetIt.I<NavigationService>().pop();
            },
          ),
        ),
      ],
    );
  }
}
