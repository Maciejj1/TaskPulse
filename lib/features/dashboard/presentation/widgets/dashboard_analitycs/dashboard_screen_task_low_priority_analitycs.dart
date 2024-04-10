import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_container_status_box.dart';

class DashboardScreenTasksLowPriorityAnalitycs extends StatelessWidget {
  const DashboardScreenTasksLowPriorityAnalitycs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            BlocBuilder<DashboardCubit, DashboardState>(
              bloc: context.read<DashboardCubit>()..getLowPriorityTasks(),
              builder: (context, state) {
                return state.when(
                    initial: () {
                      // Handle initial state

                      return const Text('Initial state');
                    },
                    error: (message) => Text(message),
                    loading: () {
                      // Handle loading state

                      return const CircularProgressIndicator();
                    },
                    success: (tasks) {
                      int done = tasks.where((element) => element.taskStatus == 1).length;
                      int planned = tasks.where((element) => element.taskStatus == 2).length;
                      int inReview = tasks.where((element) => element.taskStatus == 3).length;
                      int executing = tasks.where((element) => element.taskStatus == 4).length;

                      return SizedBox(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    DashboardContainerStatusBox(
                                      width: 180,
                                      height: 170,
                                      colors: [
                                        ColorPalette.greenBoxBackgroundGradient1,
                                        ColorPalette.greenBoxBackgroundGradient2
                                      ],
                                      numberWithThisStatus: done,
                                      status: 'Done',
                                    ),
                                    Gap(20),
                                    DashboardContainerStatusBox(
                                      width: 180,
                                      height: 120,
                                      colors: [
                                        ColorPalette.redBoxBackgroundGradient1,
                                        ColorPalette.redBoxBackgroundGradient2
                                      ],
                                      numberWithThisStatus: executing,
                                      status: 'Executing',
                                    ),
                                  ],
                                ),
                                Gap(20),
                                Column(
                                  children: [
                                    DashboardContainerStatusBox(
                                      width: 180,
                                      height: 120,
                                      colors: [
                                        ColorPalette.yellowBoxBackgroundGradient1,
                                        ColorPalette.yellowBoxBackgroundGradient2
                                      ],
                                      numberWithThisStatus: planned,
                                      status: 'Planned',
                                    ),
                                    Gap(20),
                                    DashboardContainerStatusBox(
                                      width: 180,
                                      height: 170,
                                      colors: [
                                        ColorPalette.blueBoxBackgroundGradient1,
                                        ColorPalette.blueBoxBackgroundGradient2
                                      ],
                                      numberWithThisStatus: inReview,
                                      status: 'In review',
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
