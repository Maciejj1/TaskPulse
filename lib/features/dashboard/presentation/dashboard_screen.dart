import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_high_priority_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_analitycs/dashboard_screen_task_low_priority_analitycs.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/dashboard_profile.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  child: TaskPulseLogoHeader(
                    color: ColorPalette.darkBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    Images.userAvatar,
                    width: 50,
                    height: 50,
                  ),
                )
              ],
            ),
            const Gap(20),
            const DashboardProfile(),
            const Gap(20),
            const DashboardWeather(),
            const Gap(20),
            SizedBox(
              height: 50.h,
              width: double.maxFinite.w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 20),
                              child: SegmentedTabControl(
                                radius: const Radius.circular(20),
                                backgroundColor: ColorPalette.weatherBackgroundGradient1,
                                indicatorColor: Colors.orange.shade200,
                                tabTextColor: ColorPalette.white,
                                selectedTabTextColor: ColorPalette.darkBlue,
                                squeezeIntensity: 2,
                                height: 40.h,
                                tabPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                textStyle: Theme.of(context).textTheme.bodyMedium,
                                tabs: const [
                                  SegmentTab(label: 'All tasks', color: ColorPalette.white),
                                  SegmentTab(label: 'High priority', color: ColorPalette.white),
                                  SegmentTab(label: 'Low priority', color: ColorPalette.white),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
