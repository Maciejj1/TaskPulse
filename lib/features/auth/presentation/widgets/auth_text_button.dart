import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class AuthTextButton extends StatelessWidget {
  const AuthTextButton({
    super.key,
    required this.buttonText,
    required this.buttonMethod,
  });
  final String buttonText;
  final Function buttonMethod;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () {
              buttonMethod();
            },
            child: Text(
              buttonText,
              style: TextStyle(
                  color: ColorPalette.deepPurple, fontSize: 14.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
            ))
      ],
    );
  }
}
