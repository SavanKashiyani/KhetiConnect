import 'package:kheticonnect/data/model/GetProfileResModel.dart';

import '../../../data/api/api_caller.dart';
import '../../../data/api/api_constants.dart';
import '../../../data/model/base_response.dart';

class ProfileRepo extends ApiCaller {
  Future<GetProfileResModel?> getProfile({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.getProfile),
      onApiError: onApiError,
      thenAsync: (res) async {
        var profileResModel = GetProfileResModel.fromJson(res);
        storage.setUserInfo(profileResModel.data);
        return profileResModel;
      },
    );
  }

  Future<BaseResponse?> logout({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.post(url: ApiConstants.logout),
      onApiError: onApiError,
      then: (res) {
        return BaseResponse()..data = res;
      },
    );
  }
}
