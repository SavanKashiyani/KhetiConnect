import 'package:kheticonnect/data/model/DashboardResModel.dart';
import '../../../data/api/api_caller.dart';
import '../../../data/api/api_constants.dart';

class HomeRepo extends ApiCaller {
  Future<DashboardResModel?> getDashboard({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.dashboard),
      onApiError: onApiError,
      then: (res) => DashboardResModel.fromJson(res),
    );
  }
}
