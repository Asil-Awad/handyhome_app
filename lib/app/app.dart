import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handy_home_app/app/routes/navigation_manager.dart';
import 'package:handy_home_app/app/routes/route_constants.dart';
import 'package:handy_home_app/app/routes/routes_generator.dart';
import 'package:handy_home_app/data/network/local/local_network.dart';

import '../presentation/resources/theme_manager.dart';
import 'locator.dart';

class MyApp extends StatelessWidget {
  const MyApp._internal();

  static const _instance = MyApp._internal();

  factory MyApp() => _instance;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => SafeArea(
        child: MaterialApp(
          theme: getApplicationTheme(),
          debugShowCheckedModeBanner: false,
          // initialRoute: RouteConstants.onBoardingRoute,
            initialRoute: getIt<SharedPrefController>().getLoggedIn()
                ? RouteConstants.homeRoute
                : RouteConstants.loginRoute,
          onGenerateRoute: RouteGenerator.generateRoutes,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          navigatorKey: NavigationManager.navigatorKey,
        ),
      ),
    );
  }
}
