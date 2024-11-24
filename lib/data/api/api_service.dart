import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:kheticonnect/data/api/mock_response/json_reader.dart';

import '/data/api/api_constants.dart';
import '/data/api/custom_log_interceptor.dart';
import '/data/storage/storage.dart';

class ApiService {
  late dio.Dio _dio;
  // var shouldReturnMockResponse = kDebugMode;
  var shouldReturnMockResponse = true;

  ApiService() {
    _dio = dio.Dio(dio.BaseOptions(baseUrl: ApiConstants.baseUrl));

    _dio.options.receiveDataWhenStatusError = true;
    _dio.options.sendTimeout = const Duration(milliseconds: 60000);
    _dio.options.connectTimeout = const Duration(milliseconds: 60000);
    _dio.options.receiveTimeout = const Duration(milliseconds: 60000);
    // _dio.options.followRedirects = true; // Add this line
    _dio.options.validateStatus = (status) => true;
    _dio.options.headers.addAll({"Accept": "application/json"});
    // _dio.options.headers.addAll({"Content-Type": "application/json;charset=UTF-8"});

    /**
     * set auth token if it exists in local
     */
    setAuthToken(GetIt.I.get<StorageService>().authToken);
    _dio.interceptors.add(internetCheckInterceptor);
    _dio.interceptors
        .add(CustomLogInterceptor(requestBody: true, responseBody: true));
  }

  Future<dio.Response<T>> get<T>({
    required String url,
    Map<String, dynamic>? queryParams,
    bool isCompleteUrl = false,
  }) async {
    dio.Response<T>? mockRes = await tryGetMockResponse(url);
    if (mockRes != null) {
      return mockRes;
    }
    return isCompleteUrl
        ? _dio.getUri(Uri(path: url, queryParameters: queryParams))
        : _dio.get(url, queryParameters: queryParams);
  }

  /// pass FormData.fromMap() as data in case of form data type
  Future<dio.Response<T>> post<T>({
    required String url,
    data,
    Map<String, dynamic>? queryParams,
    bool isCompleteUrl = false,
  }) async {
    dio.Response<T>? mockRes = await tryGetMockResponse(url);
    if (mockRes != null) {
      return mockRes;
    }
    return isCompleteUrl
        ? _dio.postUri(
            Uri(path: url, queryParameters: queryParams),
            data: data,
            options: data is FormData
                ? dio.Options(
                    contentType: dio.Headers.formUrlEncodedContentType,
                  )
                : null,
          )
        : _dio.post(
            url,
            queryParameters: queryParams,
            data: data,
            options: data is FormData
                ? dio.Options(
                    contentType: dio.Headers.jsonContentType,
                  )
                : null,
          );
  }

  Future<dio.Response<T>> delete<T>({
    required String url,
    data,
    Map<String, dynamic>? queryParams,
    bool isCompleteUrl = false,
  }) async {
    dio.Response<T>? mockRes = await tryGetMockResponse(url);
    if (mockRes != null) {
      return mockRes;
    }
    return isCompleteUrl
        ? _dio.deleteUri(
            Uri(path: url, queryParameters: queryParams),
            data: data,
          )
        : _dio.delete(url, queryParameters: queryParams, data: data);
  }

  Future<dio.Response<T>> patch<T>({
    required String url,
    data,
    Map<String, dynamic>? queryParams,
    bool isCompleteUrl = false,
  }) async {
    dio.Response<T>? mockRes = await tryGetMockResponse(url);
    if (mockRes != null) {
      return mockRes;
    }
    return isCompleteUrl
        ? _dio.patchUri(
            Uri(path: url, queryParameters: queryParams),
            data: data,
          )
        : _dio.patch(url, queryParameters: queryParams, data: data);
  }

  void setAuthToken(String token) {
    if (token.isNotEmpty) {
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
    }
  }

  Future<Response<T>?>? tryGetMockResponse<T>(String url) async {
    if (!shouldReturnMockResponse) {
      return null;
    }
    var mockResData = await JsonReader.readJsonFile(url.replaceAll("/", "-"));
    if(mockResData == null) {
      return null;
    }
    return Response<T>(
        data: mockResData,
        statusCode: 200,
        requestOptions: dio.RequestOptions());
  }
}
