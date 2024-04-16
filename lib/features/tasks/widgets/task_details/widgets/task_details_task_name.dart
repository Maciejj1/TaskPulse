import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class TaskDetailsHeaderTaskName extends StatelessWidget {
  const TaskDetailsHeaderTaskName({
    super.key,
    required this.taskName,
  });
  final String taskName;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                context.go('/tasks');
              },
              icon: const Icon(Iconsax.arrow_left_2_outline, color: ColorPalette.white)),
          Text(taskName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: ColorPalette.white)),
        ],
      ),
    );
  }
}
