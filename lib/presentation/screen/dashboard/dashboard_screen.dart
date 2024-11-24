import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/gen/colors.gen.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/screen/dashboard/bloc/dashboard_bloc.dart';
import 'package:kheticonnect/presentation/screen/dashboard/bloc/dashboard_event.dart';
import 'package:kheticonnect/presentation/screen/dashboard/bloc/dashboard_state.dart';

import '../../../resources/strings.dart';
import '../../../util/text_styles.dart';
import '../../custom/widget/custom_bottom_app_bar.dart';

class DashboardScreen extends BaseWidget {
  final int index;

  DashboardScreen({Key? key, this.index = 0}) : super(key: key);

  final dashboardBloc = DashboardBloc();

  // final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: dashboardBloc..add(GetProfileEvent()),
        builder: (context, state) {
          int currentIndex = index;
          if (state is TabChangedState) {
            currentIndex = BottomBarEnum.values.indexOf(state.bottomBarEnum);
          }
          return Scaffold(
            backgroundColor: ColorName.gray50,
            appBar: _buildHeader(),
            resizeToAvoidBottomInset: false,
            body: dashboardBloc.listOfScreens[currentIndex],
            bottomNavigationBar: _buildBottomNavbar(context, currentIndex),
            extendBody: true,
          );
        });
  }

  PreferredSize _buildHeader() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: BlocBuilder(
        bloc: dashboardBloc,
        buildWhen: (previous, current) =>
            current is TabChangedState || current is InitialState,
        builder: (context, state) {
          return Container(
            alignment: Alignment.centerLeft,
            color: ColorName.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: SafeArea(
              child: _buildTitle(state is TabChangedState ? state : null),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitle(TabChangedState? state) {
    Widget? widget;
    switch (state?.bottomBarEnum) {
      case BottomBarEnum.myRentals:
        widget = Text(
          Strings.myRentals(),
          style: TextStyles.exo.bold.of(20, color: ColorName.gray800),
        );
        break;
      case BottomBarEnum.account:
        widget = Text(
          Strings.myAccount(),
          style: TextStyles.exo.bold.of(20, color: ColorName.gray800),
        );
        break;
      case BottomBarEnum.home:
      default:
        widget = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.greetingTitle(storage.userInfo.fullName != null &&
                      storage.userInfo.fullName!.split(' ').length > 1
                  ? storage.userInfo.fullName?.split(' ').firstOrNull ?? ''
                  : storage.userInfo.fullName),
              style: TextStyles.exo.bold.of(20, color: ColorName.gray800),
            ),
            Text(
              _getGreetingMessage(),
              style: TextStyles.jakarta.semiBold
                  .of(12, color: ColorName.primary400),
            ),
          ],
        );
    }
    return widget;
  }

  String _getGreetingMessage() {
    DateTime now = DateTime.now();
    int hour = now.hour;
    if (hour >= 5 && hour < 12) {
      return Strings.goodMorning();
    } else if (hour >= 12 && hour < 17) {
      return Strings.goodAfternoon();
    } else {
      // if (hour >= 17 && hour < 21)
      return Strings.goodEvening();
    }
    // else {
    //   return 'Good Night';
    // }
  }

  Widget _buildBottomNavbar(BuildContext context, int currentIndex) {
    return CustomBottomAppBar(
      selectedTab: currentIndex >= 2 ? currentIndex + 1 : currentIndex,
      onChanged: (BottomBarEnum type) {
        int index = BottomBarEnum.values.indexOf(type);
        if (index != currentIndex) {
          dashboardBloc.add(TabChangeEvent(type));
        }
      },
    );
  }
}
