import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.message,
  });
  final String title;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                  color: ColorPalette.white, fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: TextStyle(
                  color: ColorPalette.grey, fontSize: 14.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            )
          ],
        ),
      ],
    );
  }
}
