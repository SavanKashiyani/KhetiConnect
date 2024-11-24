import 'package:kheticonnect/presentation/base/api_render_state.dart';

abstract class SigninState extends ApiRenderState{}

class InitialState extends SigninState {}
class MobileValidationState extends SigninState {}
class OTPValidationState extends SigninState {}

class OtpSentState extends SigninState {}
class OnMobileNumberChangeState extends SigninState {}
class ResendOtpSentState extends SigninState {}

class TimerUpdateState extends SigninState {
  final int sec;
  TimerUpdateState(this.sec);
}
