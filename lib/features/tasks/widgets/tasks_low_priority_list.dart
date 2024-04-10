import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/data/models/task_response.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/features/tasks/widgets/task_add_new_task_dialog.dart';
import 'package:task_pulse/features/tasks/widgets/edit_task/task_edit_task_dialog.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TasksLowPriorityList extends StatelessWidget {
  const TasksLowPriorityList({super.key, required this.searchQuery});
  final String searchQuery;
  @override
  Widget build(BuildContext context) {
    Future<void> removeTask(TaskResponse taskResponse) async {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(title: const Text('Are you sure?'), actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    try {
                      context.read<DashboardCubit>().removeTask(taskResponse);
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.success(
                          message: 'Successfully deleted the task',
                        ),
                      );
                      Navigator.pop(context);
                    } catch (e) {
                      showTopSnackBar(
                        Overlay.of(context),
                        const CustomSnackBar.error(
                          message: 'Oops something went wrong....',
                        ),
                      );
                      rethrow;
                    }
                  },
                  child: const Text('Remove'))
            ]);
          });
    }

    Future<void> editTask(BuildContext context, TaskResponse taskResponse) async {
      showDialog(
        context: context,
        builder: (context) {
          return TaskEditTaskDialog(
            task: taskResponse,
          );
        },
      );
    }

    return BlocBuilder<DashboardCubit, DashboardState>(
      bloc: context.read<DashboardCubit>()..getLowPriorityTasks(),
      builder: (context, state) {
        return state.when(
          initial: () {
            return const Text('Initial');
          },
          loading: () {
            return const CircularProgressIndicator();
          },
          success: (tasks) {
            final filteredTasks =
                tasks.where((task) => task.taskName!.toLowerCase().startsWith(searchQuery.toLowerCase()));
            return SizedBox(
              height: 600,
              child: ListView.builder(
                  itemCount: filteredTasks.length,
                  itemBuilder: (context, index) {
                    TaskResponse task = filteredTasks.elementAt(index);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Container(
                        width: double.maxFinite,
                        height: 80.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorPalette.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Container(
                                    width: 50.w,
                                    height: 50.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: const LinearGradient(colors: [
                                          ColorPalette.weatherBackgroundGradient2,
                                          ColorPalette.purpleBoxGradient2
                                        ])),
                                    child: Icon(Iconsax.calendar_1_outline, color: ColorPalette.white, size: 25.sp),
                                  ),
                                ),
                                const Gap(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(task.taskName!,
                                        style: TextStyle(
                                            color: ColorPalette.darkBlue,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w700)),
                                    Text(task.taskDeadline!,
                                        style: TextStyle(color: ColorPalette.grey, fontSize: 12.sp)),
                                  ],
                                )
                              ],
                            )),
                            BlocBuilder<DashboardCubit, DashboardState>(
                                bloc: context.read<DashboardCubit>(),
                                builder: (context, state) {
                                  return IconButton(
                                      onPressed: () => editTask(context, task),
                                      icon: Icon(
                                        Iconsax.card_edit_outline,
                                        size: 23.sp,
                                        color: ColorPalette.yellowBoxBackgroundGradient2,
                                      ));
                                }),
                            BlocBuilder<DashboardCubit, DashboardState>(
                              bloc: context.read<DashboardCubit>(),
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () => removeTask(task),
                                    icon: Icon(
                                      Iconsax.trash_outline,
                                      size: 23.sp,
                                      color: ColorPalette.redBoxBackgroundGradient2,
                                    ));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            );
          },
          error: (message) {
            return Text(message);
          },
        );
      },
    );
  }
}
