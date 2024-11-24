import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../util/text_styles.dart';

// ignore_for_file: must_be_immutable
enum BottomBarEnum {
  home,
  myRentals,
  account;
}

class CustomBottomAppBar extends StatefulWidget {
  CustomBottomAppBar({super.key, this.selectedTab = 0, this.onChanged});

  int selectedTab;
  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomAppBarState createState() => CustomBottomAppBarState();
}

class CustomBottomAppBarState extends State<CustomBottomAppBar> {
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: Assets.drawables.icHomeUnselected.path,
      activeIcon: Assets.drawables.icHomeSelected.path,
      title: Strings.home(),
      type: BottomBarEnum.home,
    ),
    BottomMenuModel(
      icon: Assets.drawables.icMyRentalsUnselected.path,
      activeIcon: Assets.drawables.icMyRentalsSelected.path,
      title: Strings.myRentals(),
      type: BottomBarEnum.myRentals,
    ),
    BottomMenuModel(
      icon: Assets.drawables.icAccountUnselected.path,
      activeIcon: Assets.drawables.icAccountSelected.path,
      title: Strings.account(),
      type: BottomBarEnum.account,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: BottomAppBar(
        color: ColorName.white,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 24.v,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              bottomMenuList.length,
              (index) {
                return bottomMenuList[index].icon == ""
                    ? SizedBox(
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      )
                    : InkWell(
                        onTap: () {
                          widget.selectedTab = index;
                          widget.onChanged?.call(bottomMenuList[index].type);
                          setState(() {});
                        },
                        child: widget.selectedTab == index
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                    CustomImageView(
                                      imagePath:
                                          bottomMenuList[index].activeIcon,
                                      height: 24.adaptSize,
                                      width: 24.adaptSize,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 7.v),
                                      child: Text(
                                        bottomMenuList[index].title ?? "",
                                        style: TextStyles.jakarta.medium.of(
                                          12,
                                          color: ColorName.primaryRed,
                                        ),
                                      ),
                                    )
                                  ])
                            : Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomImageView(
                                    imagePath: bottomMenuList[index].icon,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 8.v),
                                    child: Text(
                                      bottomMenuList[index].title ?? "",
                                      style: TextStyles.jakarta.medium.of(
                                        12,
                                        color: ColorName.primary300,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    this.title,
    required this.type,
  });

  String icon;

  String activeIcon;

  String? title;

  BottomBarEnum type;
}
