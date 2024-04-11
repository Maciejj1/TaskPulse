// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_button.dart';

class TaskPulseSplashScreenBuilder extends StatefulWidget {
  const TaskPulseSplashScreenBuilder({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  _TaskPulseSplashScreenBuilderState createState() => _TaskPulseSplashScreenBuilderState();
}

class _TaskPulseSplashScreenBuilderState extends State<TaskPulseSplashScreenBuilder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite.h,
            child: Stack(
              children: [
                Image.asset(
                  Images.splash,
                  fit: BoxFit.cover,
                ),
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
                children: [
                  Gap(50.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        'Manage your company\'s tasks with ease',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 24.sp),
                      ),
                    ),
                  ),
                  Gap(20.h),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: double.maxFinite,
                      child: Text(
                        'Zapisuj swoje zadania , ustawia im priorytety i statusy i miej na wszystko oko',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorPalette.grey, fontSize: 14, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Gap(50.h),
                  AuthButton(
                    buttonText: 'Get Started',
                    buttonMethod: () => context.go('/login'),
                  )
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                widget.child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
