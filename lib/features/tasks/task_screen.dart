import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/widgets/task_pulse_header.dart';
import 'package:task_pulse/features/tasks/widgets/task_add_new_task_dialog.dart';
import 'package:task_pulse/features/tasks/widgets/task_search_textfield.dart';
import 'package:task_pulse/features/tasks/widgets/task_tabs.dart';
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
                const TaskPulseHeader(),
                const Gap(20),
                TaskSearchTextField(
                    searchController: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    }),
                const Gap(20),
                const TasksTabs(),
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
