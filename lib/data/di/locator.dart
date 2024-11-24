import 'package:get_it/get_it.dart';
import '/data/api/api_service.dart';
import '/data/storage/storage.dart';
import '/presentation/service/date_time.dart';
import '/presentation/service/misc.dart';
import '/presentation/service/navigation.dart';
import '/presentation/service/toast.dart';

abstract class Locator {
  static void registerDi() {
    final getIt = GetIt.instance;
    //services
    getIt.registerLazySingleton<NavigationService>(() => NavigationService());
    getIt.registerLazySingleton<StorageService>(() => StorageService());
    getIt.registerLazySingleton<ToastService>(() => ToastService());
    getIt.registerLazySingleton<ApiService>(() => ApiService());
    getIt.registerLazySingleton<DateTimeService>(() => DateTimeService());
    getIt.registerLazySingleton<MiscService>(() => MiscService());
  }
}

var appContext = GetIt.I<NavigationService>().navigatorKey.currentContext!;
