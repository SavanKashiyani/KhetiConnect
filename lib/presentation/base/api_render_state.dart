abstract class ApiRenderState {}

class Ideal extends ApiRenderState {}

class Loading extends ApiRenderState {}

class LoadMore extends ApiRenderState {}

class Refresh extends ApiRenderState {}

class OnChangeState<T> extends ApiRenderState {
  T? data;

  OnChangeState({this.data});
}

class ApiSuccess<T> extends ApiRenderState {
  T data;

  ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiRenderState {
  T data;

  ApiFailure(this.data);
}

class SuccessToast<T> extends ApiRenderState {
  T data;

  SuccessToast(this.data);
}

class ErrorToast<T> extends ApiRenderState {
  T data;

  ErrorToast(this.data);
}