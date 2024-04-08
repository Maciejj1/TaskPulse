import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/utils/helper/task_pulse_splash_screen_builder.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return TaskPulseSplashScreenBuilder(
      child: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Images.logo,
                        width: 60.w,
                        height: 60.h,
                      ),
                      Gap(10.w),
                      Text(
                        'TaskPulse',
                        style: TextStyle(color: ColorPalette.white, fontSize: 20.sp),
                      )
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
