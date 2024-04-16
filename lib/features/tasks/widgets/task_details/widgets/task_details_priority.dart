import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/tasks/models/task_response.dart';

class TaskDetailsPriority extends StatelessWidget {
  const TaskDetailsPriority({
    super.key,
    required this.tasks,
  });
  final TaskResponse tasks;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Priority', style: TextStyle(color: ColorPalette.white, fontSize: 14, fontWeight: FontWeight.w500)),
        const Gap(2),
        Container(
          width: 150,
          height: 30,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: tasks.taskPriority == 2
                  ? [ColorPalette.redBoxBackgroundGradient1, ColorPalette.redBoxBackgroundGradient2]
                  : [ColorPalette.blueBoxBackgroundGradient2, ColorPalette.blueBoxBackgroundGradient2],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tasks.taskPriority == 1 ? 'Low' : 'High',
                  style: const TextStyle(color: ColorPalette.white, fontSize: 16, fontWeight: FontWeight.w400)),
            ],
          ),
        ),
        const Gap(2),
      ]),
    );
  }
}
