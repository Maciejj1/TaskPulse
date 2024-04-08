import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class ErrorContainer extends StatelessWidget {
  final String? errorMessage;

  const ErrorContainer({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        width: 300.w,
        height: 35.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.redBoxBackgroundGradient1,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              errorMessage ?? '',
              style: TextStyle(color: ColorPalette.redBoxBackgroundGradient2, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
