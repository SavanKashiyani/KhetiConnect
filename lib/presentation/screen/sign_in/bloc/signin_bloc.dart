import 'package:kheticonnect/presentation/base/base_bloc.dart';
import 'package:kheticonnect/presentation/screen/sign_in/bloc/signin_repo.dart';
import '../../../../util/validation_functions.dart';
import '../../../base/api_render_state.dart';
import './signin_event.dart';
import './signin_state.dart';

class SigninBloc extends BaseBloc<SigninEvent, ApiRenderState> {
  final _signinRepo = SigninRepo();
  var isOTPSent = false;

  SigninBloc() : super(InitialState()) {
    on<OnSendOTPEvent>((event, emit) async {
      if (isValidPhone(event.phoneNumber, isRequired: true)) {
        emit(Loading());
        var resSuccess = await _signinRepo.doSignIn(
            phoneNumber: event.phoneNumber, onApiError: onApiError);
        if (resSuccess == true) {
          isOTPSent = true;
          emit(OtpSentState());
        }
      } else {
        emit(MobileValidationState());
      }
    });

    on<OnMobileNumberChangeEvent>((event, emit) async {
      if(isOTPSent) {
        isOTPSent = false;
        emit(OnMobileNumberChangeState());
      }
    });

    on<OnVerifyOTPEvent>((event, emit) async {
      if(event.otp.length == 4) {
        emit(Loading());
        var resSuccess = await _signinRepo.verifyOtp(
            phoneNumber: event.phoneNumber,
            otp: event.otp,
            onApiError: onApiError);
        if (resSuccess != null && resSuccess["data"] != null) {
          emit(ApiSuccess(resSuccess));
        }
      } else {
        emit(OTPValidationState());
      }
    });

    on<OnResendOTPEvent>((event, emit) async {
      emit(Loading());
      var resSuccess = await _signinRepo.doSignIn(
          phoneNumber: event.phoneNumber, onApiError: onApiError);
      if (resSuccess == true) {
        isOTPSent = true;
        emit(ResendOtpSentState());
      }
    });

    on<StartTimerEvent>((event, emit) async {
      //set timer for 30 sec and get updated sec to the state to update view
      for (int i = 30; i >= 0; i--) {
        await Future.delayed(const Duration(seconds: 1));
        if (isOTPSent == false) {
          break;
        }
        emit(TimerUpdateState(i));
      }
    });
  }
}
