import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/widgets/task_pulse_header.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_high_priority_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_low_priority_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/dashboard_profile.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_tabs.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

import 'widgets/dashboard_weather/dashboard_weather.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
        child: SafeArea(
      child: SingleChildScrollView(
          child: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            const TaskPulseHeader(),
            const Gap(20),
            const DashboardProfile(),
            const Gap(20),
            const DashboardWeather(),
            const Gap(20),
            const DashboardTabs(),
            const Gap(20),
            SizedBox(
              height: 350.h,
              child: const TabBarView(
                physics: BouncingScrollPhysics(),
                children: [
                  DashboardScreenTasksAnalitycs(),
                  DashboardScreenTasksHighPriorityAnalitycs(),
                  DashboardScreenTasksLowPriorityAnalitycs(),
                ],
              ),
            ),
          ],
        ),
      )),
    ));
  }
}
