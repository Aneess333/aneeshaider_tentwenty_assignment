import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:tentwenty_assessment/buisnessLogic/bloc/movieDetailBloc/movie_details_bloc.dart';
import 'package:tentwenty_assessment/buisnessLogic/bloc/upcomingMoviesBloc/upcoming_bloc.dart';
import 'package:tentwenty_assessment/presentation/router/routes.dart';
import 'package:tentwenty_assessment/presentation/screens/movie_detail.dart';
import 'package:tentwenty_assessment/presentation/screens/trailer_screen.dart';

import '../../buisnessLogic/cubit/navigationBarCubit/navigation_bar_cubit.dart';
import '../../dataProvider/network/network_api_client.dart';
import '../../helper/constants/constant_resources.dart';
import '../../repository/data_manager.dart';
import '../screens/home_screen.dart';

class AppRouter {
  AppRouter({required this.packageInfo}) {
    Dio dio = Dio(
      (BaseOptions(
          contentType: ConstantsResource.CONTENT_TYPE,
          headers: {
            "Accept": ConstantsResource.CONTENT_TYPE,
          },
          baseUrl: ConstantsResource.BASE_URL)),
    );
    dio.options.headers['Authorization'] =
        'Bearer ${ConstantsResource.API_KEY}';
    dio.interceptors
        .add(PrettyDioLogger(requestBody: true, requestHeader: true));
    dataManager = DataManager(networkApiClient: NetworkApiClient(dio));
  }

  final PackageInfo packageInfo;
  static late DataManager dataManager;

  Route? generateRoute(RouteSettings routeSettings) {
    String route = routeSettings.name ?? "";
    switch (route) {
      case HOME_SCREEN_ROUTE:
        {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(providers: [
                    BlocProvider(
                      create: (context) => NavigationBarCubit(),
                    ),
                    BlocProvider(
                      create: (context) => UpcomingBloc(dataManager),
                    ),
                  ], child: HomeScreen()));
        }
      case MOVIE_DETAIL_ROUTE:
        {
          dynamic arg = routeSettings.arguments;
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => MovieDetailsBloc(dataManager),
                        ),
                      ],
                      child: MovieDetailScreen(
                        movieId: arg,
                      )));
        }case VIDEO_PLAYER_SCREEN:
        {
          dynamic arg = routeSettings.arguments;
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) => MovieDetailsBloc(dataManager),
                        ),
                      ],
                      child: TrailerScreen(
                        videoUrl: arg,
                      )));
        }

      default:
        return null;
    }
  }

  void dispose() {}
}
