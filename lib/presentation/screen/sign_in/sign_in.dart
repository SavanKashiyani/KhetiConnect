import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'package:kheticonnect/data/di/locator.dart';
import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_widget.dart';
import 'package:kheticonnect/presentation/custom/widget/loader.dart';
import 'package:kheticonnect/presentation/screen/sign_in/bloc/signin_bloc.dart';
import 'package:kheticonnect/util/extensions.dart';
import '../../../util/text_styles.dart';
import '../../custom/widget/button/custom_button.dart';
import '../../custom/widget/custom_pin_code_text_field.dart';
import '../../service/navigation.dart';
import 'bloc/signin_event.dart';
import 'bloc/signin_state.dart';

//ignore: must_be_immutable
class SignInScreen extends BaseWidget {
  SignInScreen({Key? key})
      : super(
          key: key,
        );

  final _blocSignIn = SigninBloc();
  final TextEditingController _phoneController = TextEditingController();
  String _otpController = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _blocSignIn,
      listener: (BuildContext context, state) {
        if(state is MobileValidationState){
          showError(Strings.validPhoneNumber());
        } else if(state is OTPValidationState){
          showError(Strings.invalidOTP());
        } else if(state is ApiSuccess){
          navigation.push(Routes.dashboard());
        }else if(state is ApiFailure){
          showError(state.data);
        }
      },
      builder: (BuildContext context, ApiRenderState state) {
        var sec = 30;
        if (state is TimerUpdateState) {
          sec = state.sec;
        }
        return StackLoader(
          state: state,
          child: Scaffold(
            backgroundColor: ColorName.whiteBg,
            body: Stack(
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  height: double.infinity,
                  width: double.maxFinite,
                  child: _buildImageRow(context),
                ),
                _buildMainContent(context, sec),
              ],
            ),
          ),
        );
      }
    );
  }


  Widget _buildPhoneNumberSection(BuildContext context) {
    return CustomTextField(
      title: Strings.phoneNumber(),
      controller: _phoneController,
      textInputType: TextInputType.phone,
      maxLength: 10,
      hintText: Strings.enterPhoneNumber(),
      prefix: Assets.images.imgMobiles.svg(
        height: 24.adaptSize,
        width: 24.adaptSize,
      ),
      onChanged: (value) {
        _blocSignIn.add(OnMobileNumberChangeEvent(phoneNumber: _phoneController.text));
      },
    );
  }


  Widget _buildContinueButton(BuildContext context) {
    return CustomElevatedButton(
      text: _blocSignIn.isOTPSent ? Strings.verifyOtp() : Strings.sendOtp(),
      rightIcon: Assets.images.imgArrowright,
      buttonStyle: CustomButtonStyles.fillPrimary,
      onPressed: () {
        _blocSignIn.isOTPSent
            ? _blocSignIn.add(
                OnVerifyOTPEvent(_otpController, _phoneController.text))
            : _blocSignIn
                .add(OnSendOTPEvent(phoneNumber: _phoneController.text));
      },
    );
  }


  Widget _buildMainContent(BuildContext context, int sec) {
    return Container(
      height: double.infinity,
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 14.h),
      padding: EdgeInsets.symmetric(horizontal: 8.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            addHeight(98.v),
            Assets.images.icLogo.image(height: 78.v, width: 80.h),
            addHeight(16.v),
            _renderWelcome(),
            addHeight(68.v),
            addHeight(20.v),
            _buildPhoneNumberSection(context),
            if(_blocSignIn.isOTPSent) _buildVerificationSection(context, sec),
            addHeight(32.v),
            _buildContinueButton(context)
          ],
        ),
      ),
    );
  }

  Widget _buildImageRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Assets.images.icLoginTransLogo.svg(colorFilter: const ColorFilter.mode(ColorName.gray100, BlendMode.srcIn)),
        Transform.flip(flipX: true, child: Assets.images.icLoginTransLogo.svg(colorFilter: const ColorFilter.mode(ColorName.gray100, BlendMode.srcIn))),
      ],
    );
  }


  _renderWelcome() {
    return CustomText(
      text: Strings.welcome(),
      style: TextStyles.exo.bold.of(30, color: ColorName.primary),
    );
  }

  Widget _buildVerificationSection(BuildContext context, int sec) {
      return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: 20.v),
        child: Column(
          children: [
            ..._renderMsgOtpVerification(),
            ..._renderPincodeView(context),
            _renderResendOtpButton(sec),
          ],
        ),
      );
  }

  _renderMsgOtpVerification() {
    return [
      Align(
        alignment: Alignment.centerLeft,
        child: CustomText(
          text: Strings.msgOtpVerification(),
          style: TextStyles.jakarta.medium.of(16, color: ColorName.gray500),
        ),
      ),
      addHeight(30.v),
    ];
  }

  _renderPincodeView(BuildContext context) {
    return [
      Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(
          left: 38.h,
          right: 40.h,
        ),
        child: CustomPinCodeTextField(
          context: appContext,
          onChanged: (value) {
            _otpController = value;
            if (value.length == 4) {
              _blocSignIn.add(OnVerifyOTPEvent(value, _phoneController.text));
            }
          },
        ),
      ),
      addHeight(32.v),
    ];
  }

  _renderResendOtpButton(int sec) {
    return CustomButton(
      isFilled: false,
      isEnabled: sec == 0,
      // width: 166.h,
      buttonText:
      sec > 0 ? "${Strings.resendOtp()} in $sec Sec" : Strings.resendOtp(),
      onClick: () {
        _blocSignIn.add(OnResendOTPEvent(_phoneController.text));
      },
    );
  }
}
