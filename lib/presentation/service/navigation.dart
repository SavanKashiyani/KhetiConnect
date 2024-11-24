import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:kheticonnect/presentation/screen/account/my_account.dart';
import 'package:kheticonnect/presentation/screen/account/my_fav/fav_product_list.dart';
import 'package:kheticonnect/presentation/screen/categories/category_list_screen.dart';
import 'package:kheticonnect/presentation/screen/dashboard/dashboard_screen.dart';
import 'package:kheticonnect/presentation/screen/product_details/product_image_zoom.dart';
import 'package:kheticonnect/presentation/screen/sign_in/sign_in.dart';

import '../../data/model/model_seller_details.dart';
import '../../data/model/product.dart';
import '../screen/account/contact_us/contact_us.dart';
import '../screen/product_details/product_detail_screen.dart';
import '../screen/product_details/report/report_product_screen.dart';
import '../screen/product_list/list_type.dart';
import '../screen/product_list/product_list_screen.dart';
import '../screen/splash/splash.dart';

final class Screen {
  static Set<Screen> routes = HashSet();
  late String name;
  late Widget Function(Object? arguments) widget;

  Screen(this.name, this.widget) {
    routes.removeWhere((element) => element.name == name);
    routes.add(this);
  }
}

class Routes {
  static final Screen splash = Screen('splash', (arguments) => SplashScreen());
  static final Screen signIn = Screen('signin', (arguments) => SignInScreen());
  static  Screen dashboard({int index = 0}) => Screen('dashboard', (arguments) => DashboardScreen(index: index));
  static final Screen myAccount = Screen('myAccount', (arguments) => MyAccountScreen());
  static final Screen myFavScreen = Screen('myFavScreen', (arguments) => MyFavProductListScreen());
  static final Screen contactUs = Screen('contactUs', (arguments) => ContactUsScreen());
  static Screen productDetail(Product product) => Screen('productDetail', (arguments) => ProductDetailScreen(product: product));
  static Screen reportProduct({Product? product, ModelSellerDetails? sellerData, bool isSeller = true}) => Screen('reportProduct', (arguments) => ReportProductScreen(product: product,sellerData:  sellerData, isSeller: isSeller,));
  static Screen productImageZoom(List<String?> productImages, int index) => Screen('productImageZoom', (arguments) => ProductImageZoomScreen(productImages, index));

  static Screen productList({
    String? title,
    int columns = 2,
    bool isNavigatedFromSearch = false,
    bool isNavigatedFromFilter = false,
    String? categoryId,
    ListType? listType,
  }) =>
      Screen(
        'productList',
        (arguments) => ProductListScreen(
          title: title,
          columns: columns,
          isNavigatedFromSearch: isNavigatedFromSearch,
          isNavigatedFromFilter: isNavigatedFromFilter,
          categoryId: categoryId,
          listType: listType,
        ),
      );
  static final Screen categories = Screen("categories", (arguments) => CategoryListScreen());
}

Route onGenerateRoute(RouteSettings settings) {
  Widget page = Screen.routes.firstWhere((element) => element.name == settings.name, orElse: () => Screen("", (arguments) => Container())).widget(settings.arguments);

  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    settings: settings,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> push(Screen screen, {Object? arguments}) => navigatorKey.currentState!.pushNamed(screen.name, arguments: arguments);

  Future<dynamic> pushReplacement(Screen screen, {Object? arguments}) => navigatorKey.currentState!.pushReplacementNamed(screen.name, arguments: arguments);

  Future<dynamic> pushAndRemoveUntil(Screen screen, {Object? arguments, Screen? backstackScreen}) => backstackScreen == null
      ? navigatorKey.currentState!.pushNamedAndRemoveUntil(
          screen.name,
          arguments: arguments,
          (route) => false,
        )
      : navigatorKey.currentState!.pushNamedAndRemoveUntil(
          screen.name,
          ModalRoute.withName(backstackScreen.name),
          arguments: arguments,
        );

  void pop({Object? result}) => navigatorKey.currentState!.pop(result);

  void popUntil(Screen screen) => navigatorKey.currentState!.popUntil(
        (route) => route.settings.name == screen.name,
      );
}
