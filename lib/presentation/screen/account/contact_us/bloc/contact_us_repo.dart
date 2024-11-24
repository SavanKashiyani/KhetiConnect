import 'package:kheticonnect/data/api/api_caller.dart';
import 'package:kheticonnect/data/model/model_contact_us.dart';

import '../../../../../data/api/api_constants.dart';

class ContactUsRepo extends ApiCaller {
  Future<ModelContactUs?> getContactData({
    Function(dynamic errorRes)? onApiError,
  }) async {
    return await execute(
      apiCaller.get(
        url: ApiConstants.contactUs,
      ),
      onApiError: onApiError,
      then: (res) => ModelContactUs.fromJson(res["data"]),
    );
  }
}
