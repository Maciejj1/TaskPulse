import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_pulse/firebase_options.dart';
import 'package:task_pulse/taskpulse.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Uruchamianie aplikacji w strefie do obsługi błędów
//   runZonedGuarded(
//     () async {
//       // Ustawianie preferowanych orientacji urządzenia
//       return SystemChrome.setPreferredOrientations(
//         [
//           DeviceOrientation.portraitUp,
//           DeviceOrientation.portraitDown,
//         ],
//       ).then((_) => runApp(const Connectify()));
//     },
//     // Obsługa błędów za pomocą Firebase Crashlytics
//     (error, stackTrace) async {
//       FirebaseCrashlytics.instance.recordError(error, stackTrace);
//     },
//   );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TaskPulse());
}
