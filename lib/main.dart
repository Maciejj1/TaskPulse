import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_pulse/di.dart';
import 'package:task_pulse/firebase_options.dart';
import 'package:task_pulse/taskpulse.dart';
import 'package:task_pulse/utils/services/shared/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserManager().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  configureDependencies();
  runApp(const TaskPulse());
}
