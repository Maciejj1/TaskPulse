import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/app_route.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_current_city/cubit/current_city_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/cubit/profile_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_weather/cubit/weather_cubit.dart';
import 'package:task_pulse/features/settings/widgets/cubit/settings_cubit.dart';
import 'package:task_pulse/features/tasks/widgets/edit_task/cubit/edit_task_cubit.dart';
import 'package:task_pulse/utils/helper/constant.dart';
import 'package:task_pulse/utils/helper/logger.dart';

class TaskPulse extends StatelessWidget {
  const TaskPulse({super.key}); // Konstruktor klasy Connectify

  @override
  Widget build(BuildContext context) {
    // Ustawienie stylu nakładki interfejsu systemowego
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    log.d(const String.fromEnvironment('ENV')); // Logowanie środowiska aplikacji
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
        ),
        BlocProvider<DashboardCubit>(
          create: (context) => DashboardCubit(DashboardRepository(DashboardRemoteDatasourceImpl())),
        ),
        BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(DashboardRepository(DashboardRemoteDatasourceImpl()))),
        BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(DashboardRepository(DashboardRemoteDatasourceImpl()))),
        BlocProvider<CurrentCityCubit>(
            create: (context) => CurrentCityCubit(DashboardRepository(DashboardRemoteDatasourceImpl()))),
        BlocProvider<EditTaskCubit>(
          create: (context) => EditTaskCubit(DashboardRepository(DashboardRemoteDatasourceImpl())),
        ),
        BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(DashboardRepository(DashboardRemoteDatasourceImpl()))),
      ],
      child: ScreenUtilInit(
        // Inicjalizacja narzędzia do dostosowywania rozmiaru ekranu
        designSize: const Size(430, 932), // Rozmiar projektowy ekranu
        minTextAdapt: true, // Minimalne dostosowanie tekstu
        splitScreenMode: true, // Tryb podziału ekranu
        builder: (_, child) {
          AppRoute.setStream(_); // Ustawienie strumienia tras aplikacji
          return MaterialApp.router(
            routeInformationProvider: AppRoute.router.routeInformationProvider,
            routeInformationParser: AppRoute.router.routeInformationParser,
            routerDelegate: AppRoute.router.routerDelegate,
            debugShowCheckedModeBanner: false, // Wyłączenie baneru debugowania
            builder: (BuildContext context, Widget? child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                  data: data.copyWith(alwaysUse24HourFormat: true, textScaler: const TextScaler.linear(1)),
                  child: child!);
            },
            title: Constants.get.appName, // Tytuł aplikacji
          );
        },
      ),
    );
  }
}
