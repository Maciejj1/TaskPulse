import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/auth/data/models/user_model.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/features/tasks/widgets/edit_task/cubit/edit_task_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TaskEditTaskDialog extends StatefulWidget {
  const TaskEditTaskDialog({super.key, required this.task});
  final TaskResponse task;
  @override
  State<TaskEditTaskDialog> createState() => _TaskEditTaskDialogState();
}

class _TaskEditTaskDialogState extends State<TaskEditTaskDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDeadline;
  int? priority;
  int? status;
  User? selectedUser;
  String? userString;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.task.taskName!;
    descriptionController.text = widget.task.taskDesciption!;
    selectedDeadline = DateTime.parse(widget.task.taskDeadline!); // Convert taskDeadline to DateTime
    priority = widget.task.taskPriority;
    status = widget.task.taskStatus;
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDeadline) {
      setState(() {
        selectedDeadline = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: const Text('Edit Task'),
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
            BlocBuilder<EditTaskCubit, EditTaskState>(
              bloc: context.read<EditTaskCubit>()..getAllUsers(),
              builder: (context, state) {
                return state.when(
                  initial: () {
                    return const Text('initial');
                  },
                  loading: () {
                    return const CircularProgressIndicator();
                  },
                  success: (users) {
                    return DropdownButtonFormField<User>(
                      value: selectedUser,
                      onChanged: (user) {
                        setState(() {
                          selectedUser = user;
                        });
                      },
                      items: users.map<DropdownMenuItem<User>>((user) {
                        return DropdownMenuItem<User>(
                          value: user,
                          child: Text(user.email!),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: selectedUser?.name == null
                            ? 'Owner: ${widget.task.owner}'
                            : 'New Owner: ${selectedUser?.name}',
                        labelStyle: TextStyle(
                            color:
                                selectedUser?.name == null ? Colors.black : ColorPalette.greenBoxBackgroundGradient2),
                      ),
                    );
                  },
                  error: (message) {
                    return Text(message);
                  },
                );
              },
            )
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
              Navigator.pop(context);
              context.read<DashboardCubit>().editTask(TaskResponse(
                  id: widget.task.id,
                  taskName: nameController.text,
                  taskDesciption: descriptionController.text,
                  taskDeadline: selectedDeadline.toString(),
                  taskPriority: priority,
                  taskStatus: status,
                  owner: selectedUser == null ? widget.task.owner : selectedUser!.name));

              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(
                  message: 'Successfully edited task',
                ),
              );
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
            'Edit',
            style: TextStyle(color: ColorPalette.darkBlue),
          ),
        ),
      ],
    );
  }
}
