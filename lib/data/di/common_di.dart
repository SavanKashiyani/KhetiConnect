import 'package:get_it/get_it.dart';
import '/data/di/locator.dart';
import '/data/storage/storage.dart';
import '/presentation/service/date_time.dart';
import '/presentation/service/misc.dart';
import '/presentation/service/navigation.dart';
import '/presentation/service/toast.dart';

mixin CommonDi {
  final navigation = GetIt.I<NavigationService>();
  final storage = GetIt.I<StorageService>();
  final _toast = GetIt.I<ToastService>();
  final dateTime = GetIt.I<DateTimeService>();
  final misc = GetIt.I<MiscService>();

  void showError(String? message) {
    if (message?.isEmpty ?? true) {
      return;
    }
    _toast.errorToast(appContext, message!);
  }

  void showSuccess(String? message) {
    if (message?.isEmpty ?? true) {
      return;
    }
    _toast.successToast(appContext, message!);
  }
}
