import 'dart:io';

import 'package:flutter/cupertino.dart' as cupertino;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:localization/localization.dart';
import 'package:kheticonnect/core/app_export.dart';
import 'data/api/my_http_override.dart';
import 'data/di/locator.dart';
import 'data/storage/storage.dart';
import 'data/storage/storage_constants.dart';
import 'presentation/service/misc.dart';
import 'presentation/service/navigation.dart';
import 'resources/theme/themes.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(box);
  Locator.registerDi();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    )
  );
  GetIt.I<MiscService>().closeKeyboard();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(375, 812),
      minTextAdapt: true,
    );
    LocalJsonLocalization.delegate.directories = ['assets/languages'];
    return Sizer(
      builder: (context,  orientation,deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "KhetiConnect",
          theme: appTheme,
          supportedLocales: const [
            Locale('en'),
          ],
          locale: GetIt.I<StorageService>().appLocale,
          localizationsDelegates: [
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            cupertino.DefaultCupertinoLocalizations.delegate,
            LocalJsonLocalization.delegate,
          ],
          localeResolutionCallback: (locale, supportedLocales) {
            if (supportedLocales.contains(locale)) {
              return locale;
            }
            // default language
            return const Locale('en');
          },
          navigatorKey: GetIt.I<NavigationService>().navigatorKey,
          onGenerateRoute: onGenerateRoute,
          initialRoute: Routes.splash.name,
        );
      },
    );
  }
}
