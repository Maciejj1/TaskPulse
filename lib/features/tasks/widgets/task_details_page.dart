import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, this.taskResponse});
  final TaskResponse? taskResponse;
  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        context.go('/tasks');
                      },
                      icon: Icon(Iconsax.arrow_left_2_outline)),
                  Text(taskResponse?.taskName ?? 'ss', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
