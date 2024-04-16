import 'package:flutter/material.dart';

class TaskEditTaskDate extends StatelessWidget {
  const TaskEditTaskDate({
    super.key,
    required this.selectedDeadline,
  });

  final DateTime? selectedDeadline;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: TextField(
        controller: TextEditingController(
          text: selectedDeadline != null
              ? "${selectedDeadline!.day.toString().padLeft(2, '0')}.${selectedDeadline!.month.toString().padLeft(2, '0')}.${selectedDeadline!.year.toString()}"
              : '',
        ),
        decoration: const InputDecoration(labelText: 'Deadline'),
      ),
    );
  }
}
