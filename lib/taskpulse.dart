import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/app_route.dart';
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
    return ScreenUtilInit(
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
    );
  }
}
