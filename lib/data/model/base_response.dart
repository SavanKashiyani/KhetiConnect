class BaseResponse<T> {
  late String _error;
  late T _dataJson;
  bool isSuccess = true;

  set data(T data) {
    _dataJson = data;
  }

  T get data {
    return _dataJson;
  }

  setException(String error) {
    isSuccess = false;
    _error = error;
  }

  get getException {
    return _error;
  }

  getDataInstance() {
    Map<String, dynamic> dataMap = _dataJson as dynamic;
    return dataMap['data'];
  }

  getSuccessMessage() {
    Map<String, dynamic> dataMap = _dataJson as dynamic;
    return dataMap['meta']['message'];
  }
  getErrorMessage() {
    Map<String, dynamic> dataMap = _dataJson as dynamic;
    return dataMap['meta']['message'];
  }

}

