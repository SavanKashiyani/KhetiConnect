import 'package:kheticonnect/data/model/GetCategoriesResModel.dart';

import '../../../data/api/api_caller.dart';
import '../../../data/api/api_constants.dart';

class CategoriesRepo extends ApiCaller {
  Future<GetCategoriesResModel?> getCategories({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(url: ApiConstants.getCategories),
      onApiError: onApiError,
      then: (res) => GetCategoriesResModel.fromJson(res),
    );
  }
}
