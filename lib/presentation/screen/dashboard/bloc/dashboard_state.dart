import 'package:kheticonnect/presentation/base/api_render_state.dart';

import '../../../custom/widget/custom_bottom_app_bar.dart';

abstract class DashboardState extends ApiRenderState{}

class InitialState extends DashboardState {}

class TabChangedState extends DashboardState {
  final BottomBarEnum bottomBarEnum;

  TabChangedState(this.bottomBarEnum);
}