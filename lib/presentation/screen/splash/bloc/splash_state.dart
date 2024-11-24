import 'package:kheticonnect/presentation/base/api_render_state.dart';

abstract class SplashState extends ApiRenderState{}

class InitialState extends SplashState {}

class GotoLoginState extends SplashState {}
class GotoDashboardState extends SplashState {}
