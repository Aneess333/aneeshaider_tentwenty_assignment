import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:tentwenty_assessment/presentation/router/app_router.dart';
import 'package:tentwenty_assessment/presentation/router/routes.dart';

import 'dataProvider/network/MyHttpOverrides.dart';
import 'helper/constants/constant_resources.dart';
import 'helper/constants/dimension_resources.dart';
import 'helper/theme/app_theme.dart';
final GlobalKey<NavigatorState> globalNavigator = GlobalKey<NavigatorState>();
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  AppRouter appRouter = AppRouter(packageInfo: packageInfo);
  runApp( MyApp(appRouter: appRouter,));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        designSize: const Size(ConstantsResource.APP_DESIGN_WIDTH,
            ConstantsResource.APP_DESIGN_HEIGHT),
      useInheritedMediaQuery: true,
      minTextAdapt: true,
      splitScreenMode: true,
    builder: (context, child) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: MaterialApp(
              builder: (context,child){
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(textScaler: const TextScaler.linear(Dim.D_1)),
                  child: child ?? Container(),
                );
              },
              debugShowCheckedModeBanner: false,
              initialRoute: HOME_SCREEN_ROUTE,
              navigatorKey: globalNavigator,
              onGenerateRoute: widget.appRouter.generateRoute,
              theme: AppTheme.themeData,
            ),
          );
    }
    );
  }
}
