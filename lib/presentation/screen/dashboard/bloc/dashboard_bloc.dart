import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/base/base_bloc.dart';

import '../../account/my_account.dart';
import '../../account/profile_repo.dart';
import '../../home/home_screen.dart';
import '../../my_rentals/my_rentals.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends BaseBloc<DashboardEvent, ApiRenderState> {
  final _profileRepo = ProfileRepo();

  DashboardBloc() : super(InitialState()) {
    on<TabChangeEvent>(
      (event, emit) {
        emit(TabChangedState(event.bottomBarEnum));
      },
    );
    on<GetProfileEvent>(_getProfile);
  }

  _getProfile(event, emit) {
     _profileRepo.getProfile(onApiError: onApiError);
  }

  var listOfScreens = [
    HomeScreen(),
    MyRentalsScreen(),
    MyAccountScreen(),
  ];
}
