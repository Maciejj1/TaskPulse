import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageScreenBuilder(
      child: Center(child: Text("Dashboard")),
    );
  }
}
