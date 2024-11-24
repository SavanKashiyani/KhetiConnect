import 'package:kheticonnect/data/model/MyRentalListResModel.dart';

import '../../../data/api/api_caller.dart';
import '../../../data/api/api_constants.dart';

class MyRentalRepo extends ApiCaller {
  Future<MyRentalListResModel?> getMyRentals({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.getMyRentals),
      onApiError: onApiError,
      then: (res) => MyRentalListResModel.fromJson(res),
    );
  }
}
