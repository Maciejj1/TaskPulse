import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/tasks/widgets/task_details/cubit/task_cubit_cubit.dart';
import 'package:task_pulse/features/tasks/widgets/task_details/widgets/task_details_priority.dart';
import 'package:task_pulse/features/tasks/widgets/task_details/widgets/task_details_task_name.dart';
import 'package:task_pulse/features/tasks/widgets/task_styles.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

import 'package:intl/intl.dart';

class TaskDetailsPage extends StatelessWidget {
  const TaskDetailsPage({super.key, this.id});
  final String? id;

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
      child: SafeArea(
        child: SingleChildScrollView(
          child: BlocBuilder<TaskCubit, TaskState>(
            bloc: context.read<TaskCubit>()..getTaskById(id!),
            builder: (context, state) {
              return state.when(
                initial: () => Container(),
                loading: () => Container(),
                error: (error) => Container(),
                success: (tasks) {
                  String formattedDate = tasks.taskDeadline ?? 'Test';
                  DateTime dateTime = DateTime.parse(formattedDate);
                  formattedDate = DateFormat('dd.MM.yyyy').format(dateTime);
                  return Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.82,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [ColorPalette.purpleBoxGradient1, ColorPalette.purpleBoxGradient2])),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TaskDetailsHeaderTaskName(
                            taskName: tasks.taskName ?? 'Test',
                          ),
                          Gap(20.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TaskDetailsSection(
                                color: Colors.white,
                                sectionHeader: 'Name',
                                sectionValue: tasks.taskName ?? 'Test',
                              ),
                              Gap(20.h),
                              TaskDetailsSection(
                                color: Colors.white,
                                sectionHeader: 'Deadline',
                                sectionValue: formattedDate,
                              ),
                              Gap(20.h),
                              TaskDetailsPriority(
                                tasks: tasks,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                          ),
                        ),
                        height: 420.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(50.h),
                            TaskDetailsSection(
                              sectionHeader: 'Description',
                              sectionValue: tasks.taskDesciption ?? 'Test',
                            ),
                            Gap(50.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                const Text('Status',
                                    style:
                                        TextStyle(color: ColorPalette.grey, fontSize: 14, fontWeight: FontWeight.w500)),
                                const Gap(2),
                                Container(
                                  width: 150,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: TaskStyles.getColorForTaskStatusBackground(tasks.taskStatus),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        TaskStyles.getTextForTaskStatus(tasks.taskStatus) ?? 'Test',
                                        style: TextStyle(
                                          color: TaskStyles.getColorForTaskStatus(tasks.taskStatus),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Gap(50.h),
                            TaskDetailsSection(
                              sectionHeader: 'Owner',
                              sectionValue: tasks.owner ?? 'Test',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class TaskDetailsSection extends StatelessWidget {
  const TaskDetailsSection({
    super.key,
    required this.sectionHeader,
    required this.sectionValue,
    this.color,
  });
  final String sectionHeader;
  final String sectionValue;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(sectionHeader,
            style: TextStyle(
                color: color != null ? Colors.white : ColorPalette.grey, fontSize: 14, fontWeight: FontWeight.w500)),
        const Gap(2),
        Text(sectionValue,
            style: TextStyle(
                color: color != null ? Colors.white : ColorPalette.darkBlue,
                fontSize: 15,
                fontWeight: FontWeight.w700)),
        const Gap(2),
      ]),
    );
  }
}
