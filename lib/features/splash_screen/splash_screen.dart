import 'package:flutter/material.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/utils/helper/task_pulse_splash_screen_builder.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaskPulseSplashScreenBuilder(
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TaskPulseLogoHeader(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
