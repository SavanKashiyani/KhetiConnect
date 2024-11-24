import 'package:kheticonnect/presentation/base/api_render_state.dart';
import 'package:kheticonnect/presentation/screen/account/profile_repo.dart';

import '../../../base/base_bloc.dart';
import './my_account_event.dart';
import './my_account_state.dart';

class MyAccountBloc extends BaseBloc<MyAccountEvent, ApiRenderState> {
  final _repo = ProfileRepo();

  MyAccountBloc() : super(InitialState()) {
    // on<GetProfileEvent>(_getProfile);
    on<ShowProfileEvent>(_showProfile);
    on<LogoutEvent>(_logout);
  }

  // _getProfile(event, emit) async {
  //   var response = await _repo.getProfile(onApiError: onApiError);
  //   if (response != null) {
  //     emit(ProfileRetrievedState());
  //   }
  // }

  _showProfile(event, emit) async {
    emit(OnChangeState());
  }

  _logout(event, emit) async {
    var response = await _repo.logout();
    if (response != null) {
      if(response.data!=null && response.getSuccessMessage()!=null) {
        emit(LogoutState(response.getSuccessMessage()));
      }
    }
  }

}
