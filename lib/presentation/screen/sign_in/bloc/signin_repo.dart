import 'package:dio/dio.dart';
import 'package:kheticonnect/util/app_const.dart';

import '../../../../data/api/api_caller.dart';
import '../../../../data/api/api_constants.dart';
import '../../account/profile_repo.dart';

class SigninRepo extends ApiCaller {
  Future<bool?> doSignIn({
    required String phoneNumber,
    Function(dynamic errorRes)? onApiError,
  }) async {
    var data = FormData.fromMap(
        {'country_code': AppConst.countryCode, 'phone_number': phoneNumber});
    return await execute(
      apiCaller.post(url: ApiConstants.sendOTP, data: data),
      onApiError: onApiError,
      then: (response) => response != null,
    );
  }

  Future<Map<String, dynamic>?> verifyOtp({
    required String otp,
    required String phoneNumber,
    Function(dynamic errorRes)? onApiError,
  }) async {
    var data = FormData.fromMap({
      'country_code': AppConst.countryCode,
      'phone_number': phoneNumber,
      // 'device_token': "token",
      'device_type': AppConst.deviceType,
      'otp': otp,
    });
    return await execute(
      apiCaller.post(url: ApiConstants.verifyOTP, data: data),
      onApiError: onApiError,
      thenAsync: (res) async {
        if (res["data"]["token"] != null) {
          await storage.setAuthToken(res["data"]["token"]);
          await ProfileRepo().getProfile();
        }
        return res;
      },
    );
  }
}
