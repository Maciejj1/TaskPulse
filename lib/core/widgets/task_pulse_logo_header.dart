import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';

class TaskPulseLogoHeader extends StatelessWidget {
  const TaskPulseLogoHeader({
    super.key,
    this.color,
  });
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          children: [
            SvgPicture.asset(
              Images.logo,
              width: 50.w,
              height: 50.h,
            ),
            Gap(10.w),
            Text(
              'TaskPulse',
              style: TextStyle(
                  color: color ?? ColorPalette.white,
                  fontSize: 20.sp,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
