import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class DashboardContainerStatusBox extends StatelessWidget {
  const DashboardContainerStatusBox(
      {super.key,
      required this.width,
      required this.height,
      required this.status,
      required this.numberWithThisStatus,
      required this.colors});

  final int width;
  final int height;
  final String status;
  final int numberWithThisStatus;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(numberWithThisStatus.toString(),
              style: TextStyle(color: ColorPalette.white, fontSize: 30.sp, fontWeight: FontWeight.w600)),
          Text(status, style: TextStyle(color: ColorPalette.white, fontSize: 16.sp))
        ],
      ),
    );
  }
}
