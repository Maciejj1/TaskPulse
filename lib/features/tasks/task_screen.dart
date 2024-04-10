import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/tasks/widgets/task_add_new_task_dialog.dart';
import 'package:task_pulse/features/tasks/widgets/tasks_high_priority_list.dart';
import 'package:task_pulse/features/tasks/widgets/tasks_list.dart';
import 'package:task_pulse/features/tasks/widgets/tasks_low_priority_list.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorPalette.white),
                    child: TextFormField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      textAlignVertical: TextAlignVertical.top,
                      style: TextStyle(color: ColorPalette.darkBlue, fontSize: 14.sp, fontFamily: 'Inter'),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusColor: ColorPalette.weatherBackgroundGradient1,
                          errorStyle: TextStyle(
                              color: ColorPalette.weatherBackgroundGradient1, fontSize: 14.sp, fontFamily: 'Inter'),
                          fillColor: ColorPalette.weatherBackgroundGradient1,
                          prefixIcon: const Icon(
                            Iconsax.search_normal_outline,
                            color: ColorPalette.darkBlue,
                          ),
                          hintText: 'Search by name',
                          hintStyle: const TextStyle(color: ColorPalette.darkBlue)),
                    ),
                  ),
                ),
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
                                    radius: const Radius.circular(8),
                                    backgroundColor: ColorPalette.pageBackground,
                                    indicatorColor: Colors.orange.shade200,
                                    tabTextColor: ColorPalette.darkBlue,
                                    selectedTabTextColor: Colors.white,
                                    squeezeIntensity: 2,
                                    height: 40.h,
                                    tabPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                                    textStyle: Theme.of(context).textTheme.bodyMedium,
                                    tabs: const [
                                      SegmentTab(label: 'All tasks', color: Color(0xFF005CFD)),
                                      SegmentTab(label: 'High priority', color: Color(0xFF005CFD)),
                                      SegmentTab(label: 'Low priority', color: Color(0xFF005CFD)),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Tasks',
                              style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          width: 70,
                          height: 30,
                          child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return const TaskAddNewTaskDialog();
                                  },
                                );
                              },
                              child: const Icon(Iconsax.add_outline, color: ColorPalette.darkBlue)))
                    ],
                  ),
                ),
                const Gap(20),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.49,
                  child: TabBarView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      TasksList(
                        searchQuery: searchQuery,
                      ),
                      TasksHighPriorityList(
                        searchQuery: searchQuery,
                      ),
                      TasksLowPriorityList(
                        searchQuery: searchQuery,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
