import '../../../custom/widget/custom_bottom_app_bar.dart';

abstract class DashboardEvent {}

class TabChangeEvent extends DashboardEvent {
  final BottomBarEnum bottomBarEnum;

  TabChangeEvent(this.bottomBarEnum);
}
class GetProfileEvent extends DashboardEvent {}