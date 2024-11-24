import 'package:flutter/material.dart';
import 'package:kheticonnect/data/model/MyRentalListResModel.dart';
import 'package:kheticonnect/presentation/screen/my_rentals/bloc/my_rental_state.dart';

import '../../../base/api_render_state.dart';
import '../../../base/base_bloc.dart';
import '../my_rental_repo.dart';
import './my_rental_event.dart';

class MyRentalBloc extends BaseBloc<MyRentalEvent, ApiRenderState> {
  final _repo = MyRentalRepo();

  List<MyRentalProduct> rentalList = [];

  MyRentalBloc() : super(null) {
    on<LoadMyRentalListEvent>(_loadRentalList);
  }

  _loadRentalList(event, emit) async {
    emit(Loading());
    var response = await _repo.getMyRentals(onApiError: onApiError);
    if (response != null) {
      debugPrint("response is not null");
      rentalList.clear();
      rentalList = response.data ?? [];
      emit(RentalListRetrievedState());
    } else{
      debugPrint("response is null");}
  }
}
