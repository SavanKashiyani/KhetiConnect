abstract class SigninEvent {}

class OnSendOTPEvent implements SigninEvent {
  final String phoneNumber;

  OnSendOTPEvent({required this.phoneNumber});
}
class OnMobileNumberChangeEvent implements SigninEvent {
  final String phoneNumber;

  OnMobileNumberChangeEvent({required this.phoneNumber});
}

class OnVerifyOTPEvent extends SigninEvent{
  final String otp;
  final String phoneNumber;

  OnVerifyOTPEvent(this.otp, this.phoneNumber);
}

class OnResendOTPEvent extends SigninEvent{
  final String phoneNumber;

  OnResendOTPEvent(this.phoneNumber);
}

class StartTimerEvent extends SigninEvent {
}