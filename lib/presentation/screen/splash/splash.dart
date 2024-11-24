import 'package:flutter/services.dart';
import 'package:kheticonnect/presentation/screen/splash/bloc/splash_bloc.dart';
import 'package:kheticonnect/presentation/screen/splash/bloc/splash_event.dart';
import 'package:kheticonnect/presentation/screen/splash/bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/navigation.dart';
import '/presentation/base/base_widget.dart';
import 'package:kheticonnect/core/app_export.dart';

//ignore: must_be_immutable
class SplashScreen extends BaseWidget {
  SystemUiOverlayStyle? navStyle;

  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    navStyle = const SystemUiOverlayStyle(
      systemNavigationBarColor: ColorName.primary, // Navigation bar
      statusBarColor: Colors.transparent, // Status bar
    );
    return BlocConsumer<SplashBloc, SplashState>(
      bloc: SplashBloc()..add(StartTimerEvent()),
      listener: (context, state) {
        if (state is GotoLoginState) {
          navigation.pushAndRemoveUntil(Routes.signIn);
        } else if (state is GotoDashboardState) {
          navigation.pushAndRemoveUntil(Routes.dashboard());
        }
        navStyle = const SystemUiOverlayStyle(
          systemNavigationBarColor: ColorName.white, // Navigation bar
          statusBarColor: Colors.transparent, // Status bar
        );
      },
      builder: (BuildContext context, state) {
        return _renderSplash(context);
      },
    );
  }

  Widget _buildImage(BuildContext context) {
    return Assets.images.icLogo.image(
      height: 80.v,
      width: 222.h,
    );
  }

  _renderSplash(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      // appBar: AppBar(
      //   backgroundColor: ColorName.white,
      //   systemOverlayStyle: navStyle,
      // ),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        alignment: Alignment.center,
        padding: EdgeInsets.all(14.h),
        child: _buildImage(context),
      ),
    );
  }
}
