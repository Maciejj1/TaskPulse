import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TaskAddNewTaskDialog extends StatefulWidget {
  const TaskAddNewTaskDialog({super.key});

  @override
  State<TaskAddNewTaskDialog> createState() => _TaskAddNewTaskDialogState();
}

class _TaskAddNewTaskDialogState extends State<TaskAddNewTaskDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDeadline;
  int? priority;
  int? status = 1;
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDeadline)
      setState(() {
        selectedDeadline = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: const Text('Create Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextField(
                  controller: TextEditingController(
                    text: selectedDeadline != null
                        ? "${selectedDeadline!.day.toString().padLeft(2, '0')}.${selectedDeadline!.month.toString().padLeft(2, '0')}.${selectedDeadline!.year.toString()}"
                        : '',
                  ),
                  decoration: const InputDecoration(labelText: 'Deadline'),
                ),
              ),
            ),
            DropdownButtonFormField<int>(
              value: priority,
              onChanged: (value) {
                setState(() {
                  priority = value!;
                });
              },
              items: <int>[1, 2].map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(value == 1 ? 'Low' : 'High'), // Assuming 1 represents Low and 2 represents High
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Priority'),
            ),
            DropdownButtonFormField<int>(
              value: status,
              onChanged: (statusValue) {
                setState(() {
                  status = statusValue!;
                  print("Status: $statusValue");
                });
              },
              items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int statusValue) {
                return DropdownMenuItem<int>(
                  value: statusValue,
                  child: Text(statusValue == 1
                      ? 'Done'
                      : statusValue == 2
                          ? 'Planned'
                          : statusValue == 3
                              ? 'In review'
                              : 'Executing'),
                );
              }).toList(),
              decoration: const InputDecoration(labelText: 'Status'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'Cancel',
            style: TextStyle(color: ColorPalette.darkBlue),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            try {
              if (nameController.text.isEmpty ||
                  descriptionController.text.isEmpty ||
                  selectedDeadline == null ||
                  priority == null ||
                  status == null) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: 'You must fill in all the fields!',
                  ),
                );
              } else {
                print('StatusValue: $status');
                Navigator.pop(context);
                context.read<DashboardCubit>().addTask(TaskResponse(
                    taskName: nameController.text,
                    taskDesciption: descriptionController.text,
                    taskDeadline: selectedDeadline.toString(),
                    taskPriority: priority,
                    taskStatus: status));

                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: 'Successfully added task',
                  ),
                );
              }
            } catch (e) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.error(
                  message: 'Oops something went wrong....',
                ),
              );
            }
          },
          child: const Text(
            'Create',
            style: TextStyle(color: ColorPalette.darkBlue),
          ),
        ),
      ],
    );
  }
}
