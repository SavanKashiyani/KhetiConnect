import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/custom_alert_dialog.dart';
import 'package:kheticonnect/presentation/screen/account/bloc/my_account_bloc.dart';
import 'package:kheticonnect/presentation/screen/account/bloc/my_account_event.dart';
import 'package:kheticonnect/presentation/screen/account/bloc/my_account_state.dart';
import 'package:kheticonnect/util/app_const.dart';

import '../../../core/app_export.dart';
import '../../../data/model/user.dart';
import '../../../resources/styles/app_decoration.dart';
import '../../../util/text_styles.dart';
import '../../service/navigation.dart';

class MyAccountScreen extends BaseWidget {
  final _bloc = MyAccountBloc();

  MyAccountScreen({Key? key}) : super(key: key);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var user = storage.userInfo;
    return BlocConsumer(
        listener: (context, ApiRenderState state) {
          if (state is LogoutState) {
            navigation.pushAndRemoveUntil(Routes.signIn);
            storage.logout();
          }
        },
        bloc: _bloc,
        builder: (context, ApiRenderState state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.v),
                child: Column(
                  children: [
                    _renderUserInfo(user),
                    addHeight(16.v),
                    _renderSettingList(context)
                  ],
                ),
              ),
            ),
          );
        });
  }


  Widget _renderUserInfo(User user) {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: AppDecoration.getBoxDecoration(Colors.white).copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          CustomImageView(
            imagePath: user.profilePhoto,
            height: 64.adaptSize,
            width: 64.adaptSize,
            fit: BoxFit.cover,
            radius: BorderRadius.circular(
              8.h,
            ),
          ),
          SizedBox(width: 10.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: user.fullName ?? '',
                  style: TextStyles.jakarta.semiBold.of(
                    16,
                    color: ColorName.gray800,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                addHeight(8.v),
                CustomText(
                  text: user.email ?? '',
                  style: TextStyles.jakarta.medium.of(
                    12,
                    color: ColorName.gray600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                addHeight(2.v),
                CustomText(
                  text: "+${AppConst.countryCode} ${user.phoneNumber ?? ''}",
                  style: TextStyles.jakarta.medium.of(
                    12,
                    color: ColorName.gray600,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10.h),
          InkWell(
            onTap: () {
              //navigation.push(Routes.editProfile);
            },
            child: Assets.images.imgEdit.svg(
              width: 24.adaptSize,
              height: 24.adaptSize,
            ),
          ),
        ],
      ),
    );
  }


  Widget _renderSettingList(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.v),
          decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
          child: Column(
            children: [
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icBank.path,
                title: Strings.bankDetails(),
                onRowClick: () {
                  //navigation.push(Routes.manageBankDetails);
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icFavorite.path,
                title: Strings.myFavourites(),
                onRowClick: () {
                  navigation.push(Routes.myFavScreen);
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icClaim.path,
                title: Strings.myClaims(),
                onRowClick: () {
                  //navigation.push(Routes.myClaimsScreen);
                },
              ),
            ],
          ),
        ),
        addHeight(12.v),
        Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 5.v),
          decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icFaq.path,
                title: Strings.faqs(),
                onRowClick: () {
                  //navigation.push(Routes.faq);
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icContactUs.path,
                title: Strings.contactUs(),
                onRowClick: () {
                  navigation.push(Routes.contactUs);
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icAboutUs.path,
                title: Strings.aboutUS(),
                onRowClick: () {
                  //navigation.push(Routes.cmsPage(Strings.aboutUS(), CmsPageType.AboutUs));
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icTnc.path,
                title: Strings.termsAndConditions(),
                onRowClick: () {
                  //navigation.push(Routes.cmsPage(Strings.termsAndConditions(), CmsPageType.TnC));
                },
              ),
              divider(),
              _renderRowSetting(
                context,
                iconPath: Assets.drawables.icPrivacyPolicy.path,
                title: Strings.privacyPolicy(),
                onRowClick: () {
                  //navigation.push(Routes.cmsPage(Strings.privacyPolicy(), CmsPageType.Privacy));
                },
              ),
            ],
          ),
        ),
        addHeight(12.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.h,
            vertical: 5.v,
          ),
          decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
          width: double.maxFinite,
          child: _renderRowSetting(
            context,
            iconPath: Assets.drawables.icLogout.path,
            title: Strings.logout(),
            onRowClick: () {
              _openLogoutDialog(context);
            },
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _renderRowSetting(
    BuildContext context, {
    required String iconPath,
    required String title,
    Function? onRowClick,
  }) {
    return InkWell(
      onTap: () {
        onRowClick?.call();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImageView(
              imagePath: iconPath,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 8.h),
                child: CustomText(
                  text: title,
                  style: TextStyles.jakarta.semiBold.of(
                    14,
                    color: ColorName.gray700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const Spacer(),
            Assets.images.imgArrowright.svg(
              colorFilter:
                  const ColorFilter.mode(ColorName.gray400, BlendMode.srcIn),
              height: 20.adaptSize,
              width: 20.adaptSize,
            )
          ],
        ),
      ),
    );
  }

  void _openLogoutDialog(BuildContext context) {
    BaseAlertDialog().alertDialog(context,
        title: Strings.comebackSoon(),
        imageWidget: Container(
          height: 64.v,
          width: 64.h,
          padding: EdgeInsets.all(16.h),
          decoration: AppDecoration.getBoxDecoration(
            ColorName.primary95,
            radius: 30,
          ),
          child: CustomImageView(
            imagePath: Assets.drawables.icLogout.path,
          ),
        ),
        imagePath: Assets.drawables.icLogout.path,
        description: Strings.msgLogout(),
        positiveButtonText: Strings.logout(),
        negativeButtonText: Strings.cancel(),
        dismissible: false, onPositiveButtonClick: () {
      _bloc.add(LogoutEvent());
    });
  }
}
