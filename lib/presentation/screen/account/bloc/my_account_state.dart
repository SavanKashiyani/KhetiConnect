import 'package:kheticonnect/presentation/base/api_render_state.dart';

abstract class MyAccountState extends ApiRenderState {}

class InitialState extends MyAccountState {}

class ProfileRetrievedState extends MyAccountState {}

class LogoutState extends MyAccountState {
  final String message;

  LogoutState(this.message);
}
