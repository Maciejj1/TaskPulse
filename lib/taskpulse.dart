import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/app_route.dart';
import 'package:task_pulse/di.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:task_pulse/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_current_city/cubit/current_city_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/cubit/profile_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_weather/cubit/weather_cubit.dart';
import 'package:task_pulse/features/settings/data/datasources/settings_datasource.dart';
import 'package:task_pulse/features/settings/data/repositories/settings_repository.dart';
import 'package:task_pulse/features/settings/widgets/cubit/settings_cubit.dart';
import 'package:task_pulse/features/tasks/datasources/task_datasource.dart';
import 'package:task_pulse/features/tasks/repositories/task_repository.dart';
import 'package:task_pulse/features/tasks/widgets/edit_task/cubit/edit_task_cubit.dart';
import 'package:task_pulse/features/tasks/widgets/task_details/cubit/task_cubit_cubit.dart';
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
          create: (context) => getIt<DashboardCubit>(),
        ),
        BlocProvider<ProfileCubit>(create: (context) => getIt<ProfileCubit>()),
        BlocProvider<WeatherCubit>(create: (context) => getIt<WeatherCubit>()),
        BlocProvider<CurrentCityCubit>(create: (context) => getIt<CurrentCityCubit>()),
        BlocProvider<EditTaskCubit>(
          create: (context) => getIt<EditTaskCubit>(),
        ),
        BlocProvider<SettingsCubit>(create: (context) => getIt<SettingsCubit>()),
        BlocProvider<TaskCubit>(
          create: (context) => getIt<TaskCubit>(),
        ),
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
