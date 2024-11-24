import 'package:kheticonnect/presentation/base/base_bloc.dart';
import 'package:kheticonnect/presentation/screen/splash/bloc/splash_event.dart';
import 'package:kheticonnect/presentation/screen/splash/bloc/splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashBloc() : super(InitialState()) {
    on<StartTimerEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      if (storage.isUserLoggedIn) {
        emit(GotoDashboardState());
      } else {
        emit(GotoLoginState());
      }
    });
  }
}
