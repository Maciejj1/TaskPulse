import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> with SingleTickerProviderStateMixin {
  void doNothing(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController deadlineController = TextEditingController();
    late String priority = 'Low';
    late String status = 'In Progress';
    return PageScreenBuilder(
      child: SafeArea(
        child: SingleChildScrollView(
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
                        hintText: 'Wyszukaj po nazwie',
                        hintStyle: const TextStyle(color: ColorPalette.darkBlue)),
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 110.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorPalette.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'All Tasks',
                          style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                        ),
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: ColorPalette.blueBoxBackgroundGradient1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'Priority High',
                          style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                        ),
                      ),
                    ),
                    const Gap(5),
                    SizedBox(
                      width: 130.w,
                      height: 45.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          shadowColor: Colors.transparent,
                          backgroundColor: ColorPalette.blueBoxBackgroundGradient1,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                        ),
                        child: Text(
                          'Priority Low',
                          style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                        ),
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
                            'Zadania',
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
                                          TextField(
                                            controller: deadlineController,
                                            decoration: const InputDecoration(labelText: 'Deadline'),
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: priority,
                                            onChanged: (value) {
                                              setState(() {
                                                priority = value!;
                                              });
                                            },
                                            items:
                                                <String>['Low', 'High'].map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                            decoration: const InputDecoration(labelText: 'Priority'),
                                          ),
                                          DropdownButtonFormField<String>(
                                            value: status,
                                            onChanged: (value) {
                                              setState(() {
                                                status = value!;
                                              });
                                            },
                                            items: <String>['Done', 'Code Review', 'In Progress', 'Ongoing']
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
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
                                        onPressed: () {},
                                        child: const Text(
                                          'Create',
                                          style: TextStyle(color: ColorPalette.darkBlue),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Icon(Iconsax.add_outline, color: ColorPalette.darkBlue)))
                  ],
                ),
              ),
              const Gap(20),
              SizedBox(
                height: 100,
                child: ListView(children: [
                  Slidable(
                      // Specify a key if the Slidable is dismissible.
                      key: const ValueKey(0),

                      // The start action pane is the one at the left or the top side.
                      startActionPane: ActionPane(
                        // A motion is a widget used to control how the pane animates.
                        motion: const ScrollMotion(),

                        // A pane can dismiss the Slidable.
                        dismissible: DismissiblePane(onDismissed: () {}),

                        // All actions are defined in the children parameter.
                        children: [
                          // A SlidableAction can have an icon and/or a label.
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Iconsax.trash_outline,
                            label: 'Delete',
                          ),
                        ],
                      ),

                      // The end action pane is the one at the right or the bottom side.
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Iconsax.edit_2_outline,
                            label: 'Edit',
                          ),
                        ],
                      ),

                      // The child of the Slidable is what the user sees when the
                      // component is not dragged.
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                      Text('Design Changes',
                                          style: TextStyle(
                                              color: ColorPalette.darkBlue,
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w700)),
                                      Text('2 Day ago', style: TextStyle(color: ColorPalette.grey, fontSize: 12.sp)),
                                    ],
                                  )
                                ],
                              )),
                            ],
                          ),
                        ),
                      )),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
