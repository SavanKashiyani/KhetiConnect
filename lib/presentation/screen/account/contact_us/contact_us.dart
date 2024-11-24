import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kheticonnect/data/model/model_contact_us.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/screen/account/contact_us/bloc/contact_us_event.dart';
import 'package:kheticonnect/resources/styles/app_decoration.dart';
import 'package:kheticonnect/util/extensions.dart';
import 'package:kheticonnect/util/size_utils.dart';

import '../../../../gen/assets.gen.dart';
import '../../../../gen/colors.gen.dart';
import '../../../../resources/strings.dart';
import '../../../../util/text_styles.dart';
import '../../../../util/widget_util.dart';
import '../../../custom/widget/app_bar/custom_app_bar.dart';
import '../../../custom/widget/custom_text.dart';
import 'bloc/contact_us_bloc.dart';

//ignore: must_be_immutable
class ContactUsScreen extends BaseWidget {
  final _bloc = ContactUsBloc();

  ModelContactUs? _modelContactData;
  ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc..add(GetContactDataEvent()),
        builder: (context, state) {
          if(state is ApiSuccess) {
            _modelContactData = state.data;
          }
          return StackLoader(
            state: _bloc.state,
            child: Scaffold(
                backgroundColor: ColorName.whiteBg,
                appBar: CustomAppBar(title: Strings.contactUs()),
                body: SingleChildScrollView(
                    child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.all(16),
                        child: Column(children: [
                          _renderVersion(context),
                          addHeight(16),
                          _renderContactRow(Assets.images.icCall.svg(height: 20.v, width: 20.h), Strings.callUs(), _modelContactData?.mobileNumber ?? "", (){
                            // if(_modelContactData?.mobileNumber != null) {
                            //   misc.openPhoneDial(_modelContactData!.mobileNumber!);
                            // }
                          }),
                          addHeight(16),
                          _renderContactRow(Assets.images.icMail.svg(height: 20.v, width: 20.h), Strings.mailUs(), _modelContactData?.email ?? "",(){
                            // if(_modelContactData?.email != null) {
                            //   misc.openMail(_modelContactData!.email!);
                            // }
                          }),
                          addHeight(16),
                          _renderContactRow(Assets.drawables.icLocation.svg(height: 20.v, width: 20.h), Strings.visitUs(), _modelContactData?.address ?? "",(){
                            // if(_modelContactData?.address != null) {
                            //   misc.openMaps(_modelContactData!.address!);
                            // }
                          }),
                        ])))),
          );
        });
  }

  _renderVersion(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Assets.images.icLogo.image(height: 78.v, width: 80.h),
          addHeight(8),
          CustomText(
            text: Strings.appName(),
            style: TextStyles.exo.bold.of(24, color: ColorName.primary),
          ),
          addHeight(14),
          CustomText(
            text: "Version 1.0.0",
            style: TextStyles.jakarta.medium.of(12, color: ColorName.gray500),
          ),
        ],
      ),
    );
  }

  _renderContactRow(SvgPicture svg, String title, String info,Function onTap) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.maxFinite,
        decoration: AppDecoration.getBoxDecoration(Colors.white, radius: 8),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(height: 44.v, width : 44.h,
                padding: const EdgeInsets.all(12),
                decoration: AppDecoration.getBoxDecoration(ColorName.blue50, radius: 8),child: svg),
            addWidth(16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: title,
                  style: TextStyles.exo.semiBold.of(16, color: ColorName.gray800),
                ),
                addHeight(4),
                CustomText(
                  text: info,
                  maxLines: 2,
                  style: TextStyles.jakarta.semiBold.of(14, color: ColorName.gray500),
                ),
              ],
            ).expanded
          ],
        ),
      ),
    );
  }
}
