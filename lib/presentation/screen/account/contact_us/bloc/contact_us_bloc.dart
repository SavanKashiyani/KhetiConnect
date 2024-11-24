import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../base/api_render_state.dart';
import '../../../../base/base_bloc.dart';
import './contact_us_event.dart';
import './contact_us_state.dart';
import 'contact_us_repo.dart';

class ContactUsBloc extends BaseBloc<ContactUsEvent, ApiRenderState> {
  final _repo = ContactUsRepo();

  ContactUsBloc() : super(InitialState()) {
    on<GetContactDataEvent>(_onGetContactData);
  }

  _onGetContactData(GetContactDataEvent event, Emitter<ApiRenderState> emit) async {
    emit(Loading());
    var response = await _repo.getContactData(onApiError: onApiError);
    if (response != null) {
      emit(ApiSuccess(response));
    }
  }
}
