import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.buttonText,
    required this.buttonMethod,
  });
  final String buttonText;
  final Function buttonMethod;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200.w,
        height: 45.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              colors: [ColorPalette.weatherBackgroundGradient1, ColorPalette.weatherBackgroundGradient2],
            )),
        child: ElevatedButton(
          onPressed: () {
            buttonMethod();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Text(
            buttonText,
            style: TextStyle(color: ColorPalette.white, fontFamily: 'Poppins', fontSize: 16.sp),
          ),
        ));
  }
}
