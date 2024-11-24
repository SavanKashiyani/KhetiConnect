import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kheticonnect/data/storage/storage.dart';

import '/presentation/base/api_render_state.dart';

class BaseBloc<T, K extends ApiRenderState> extends Bloc<T, K> {
  late Function(dynamic errorRes) onApiError;
  final storage = GetIt.I<StorageService>();

  BaseBloc(ApiRenderState? initialState)
      : super((initialState as K?) ?? (Ideal() as K)) {
    onApiError = (error) {
      emit(ApiFailure(error) as K);
    };
  }

}
