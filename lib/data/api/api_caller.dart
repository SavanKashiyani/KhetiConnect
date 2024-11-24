import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../presentation/service/navigation.dart';
import '/data/api/api_service.dart';
import '/data/storage/storage.dart';
import '/util/app_const.dart';

mixin class ApiCaller {
  final apiCaller = GetIt.I.get<ApiService>();
  final storage = GetIt.I.get<StorageService>();

  Future<T?> execute<T>(
    Future<Response> apiCall, {
    Function(dynamic errorRes)? onApiError,
    T Function(dynamic res)? then,
    Future<T> Function(dynamic res)? thenAsync,
  }) async {
    try {
      if (await _isInternetConnected()) {
        var res = (await apiCall);
        var token = res.headers.map['auth_token']?.firstOrNull;
        if (token != null) {
          storage.setAuthToken(token);
        }
        String? errorMessage;
        if (res.statusCode! == 401) {
          storage.logout();
          GetIt.I<NavigationService>().pushAndRemoveUntil(Routes.signIn);
        }
        if (res.statusCode! < 200 || res.statusCode! >= 300) {
          if (res.data?['meta'] != null) {
            errorMessage = res.data['meta']['message'];
          }
        }
        if (errorMessage != null) {
          // if (errorMessage.contains(ApiConstants.unauthorisedUserErrorMessage)) {
          //   storage.logout();
          //   // GetIt.I<NavigationService>().pushAndRemoveUntil(Routes.login);
          // }
          // if (ApiConstants.cartErrorMessage.any((element) => errorMessage?.contains(element) == true)) {
          //   // CartRepo().createCartID(null);
          // }
          onApiError?.call(errorMessage);
        } else {
          if(then != null) {
            try {
              return then.call(res.data);
            } catch (e) {
              debugPrint(e.toString());
              onApiError?.call(AppConst.somethingWentWrong);
            }
          }
          if(thenAsync != null) {
            try {
              return await thenAsync.call(res.data);
            } catch (e) {
              onApiError?.call(AppConst.somethingWentWrong);
            }
          }
          return res.data;
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data != null) {
          onApiError?.call(e.response?.data);
        } else {
          if (e.type == DioExceptionType.connectionError) {
            onApiError?.call(AppConst.noInternetConnectionError);
          } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.sendTimeout || e.type == DioExceptionType.receiveTimeout) {
            onApiError?.call(AppConst.requestTimeOutError);
          } else {
            onApiError?.call(AppConst.somethingWentWrong);
          }
        }
      } else {
        onApiError?.call(AppConst.somethingWentWrong);
      }
    }
    return null;
  }

  Future<bool> _isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      throw const HttpException('Internet not connected');
    }
  }
}
