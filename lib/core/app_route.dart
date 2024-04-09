import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pulse/features/auth/presentation/forgot_password/forgot_password_screen.dart';
import 'package:task_pulse/features/auth/presentation/login/login_screen.dart';
import 'package:task_pulse/features/auth/presentation/register/presentation/register_screen.dart';
import 'package:task_pulse/features/dashboard/presentation/dashboard_screen.dart';
import 'package:task_pulse/features/settings/settings_screen.dart';
import 'package:task_pulse/features/splash_screen/splash_screen.dart';
import 'package:task_pulse/features/tasks/task_screen.dart';

import '../utils/services/shared/user_manager.dart';
// Enumeracja definiująca różne ścieżki aplikacji.

enum Routes {
  root("/"),
  splashScreen("/splashscreen"),
  login("/login"),
  register("/register"),
  forgotPassword("/forgotPassword"),
  dashboard("/dashboard"),
  tasks("/tasks"),
  taskDetails("/taskDetails"),
  settings("/settings");

  const Routes(this.path);
  final String path;
}
// Klasa pomocnicza do obsługi tras w aplikacji.

class AppRoute {
  static late BuildContext context;
  AppRoute.setStream(BuildContext ctx) {
    context = ctx;
  }
  // Statyczne pole przechowujące instancję routera.

  static final GoRouter router = GoRouter(
      routes: [
        // Konfiguracja tras dla poszczególnych ścieżek.
        GoRoute(
          path: Routes.root.path,
          name: Routes.root.name,
          redirect: (_, __) => Routes.dashboard.path,
        ),
        GoRoute(
          path: Routes.splashScreen.path,
          name: Routes.splashScreen.name,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: SplashScreen(),
          ),
        ),
        GoRoute(
          path: Routes.login.path,
          name: Routes.login.name,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: LoginScreen(),
          ),
        ),
        GoRoute(
          path: Routes.dashboard.path,
          name: Routes.dashboard.name,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: DashboardScreen(),
          ),
        ),
        GoRoute(
            path: Routes.tasks.path,
            name: Routes.tasks.name,
            pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: TasksScreen())),
        // GoRoute(
        //     path: Routes.taskDetails.path,
        //     name: Routes.taskDetails.name,
        //     pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(child: FriendsScreen())),
        GoRoute(
          path: Routes.register.path,
          name: Routes.register.name,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: RegisterScreen(),
          ),
        ),
        GoRoute(
          path: Routes.settings.path,
          name: Routes.settings.name,
          pageBuilder: (BuildContext context, GoRouterState state) => const NoTransitionPage(
            child: SettingsScreen(),
          ),
        ),

        GoRoute(
            path: Routes.forgotPassword.path,
            name: Routes.forgotPassword.name,
            pageBuilder: (BuildContext context, GoRouterState state) =>
                const NoTransitionPage(child: ForgotPasswordScreen())),
      ],
      initialLocation: Routes.splashScreen.path, // Początkowa lokalizacja.
      routerNeglect: true, // Ignorowanie routingu w pewnych przypadkach.
      debugLogDiagnostics: kDebugMode, // Logowanie diagnostyczne w trybie debugowania.
      // refreshListenable: GoRouter, // Opcjonalne odświeżanie słuchacza listy.
      redirect: (_, GoRouterState state) async {
        final bool isLoginPage = state.matchedLocation == Routes.login.path;
        final bool isRegisterPage = state.matchedLocation == Routes.register.path;
        final bool isSplashscreenPage = state.matchedLocation == Routes.splashScreen.path;
        final bool isDashboardPage = state.matchedLocation == Routes.dashboard.path;

        UserManager userManager = UserManager();
        String? userID;
        userID = await userManager.getUID();
        if (userID != null && isLoginPage || userID != null && isRegisterPage || userID != null && isSplashscreenPage) {
          return Routes.root.path;
        } else if (userID == null && isDashboardPage) {
          return Routes.login.path;
        }
        return null;
      });
  static GoRouter get gorouter => router;
}
