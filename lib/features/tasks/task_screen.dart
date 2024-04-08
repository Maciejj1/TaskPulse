import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(child: Center(child: Text("Tasks Screen")));
  }
}
