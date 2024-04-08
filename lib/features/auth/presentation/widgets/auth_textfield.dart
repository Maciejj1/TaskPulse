import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField(
      {super.key,
      required this.header,
      required this.hintText,
      required this.icon,
      required this.controller,
      this.validator,
      this.isValid});
  final String header;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? isValid;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300.w,
          child: Row(
            children: [
              Text(
                header,
                style: TextStyle(
                    color: ColorPalette.grey, fontSize: 14.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        const Gap(10),
        Container(
          width: 300.w,
          height: 45.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: TextFormField(
            validator: validator,
            controller: controller,
            textAlignVertical: TextAlignVertical.bottom,
            style: TextStyle(color: ColorPalette.white, fontSize: 14.sp, fontFamily: 'Inter'),
            decoration: InputDecoration(
                errorStyle:
                    TextStyle(color: ColorPalette.weatherBackgroundGradient1, fontSize: 14.sp, fontFamily: 'Inter'),
                fillColor: ColorPalette.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: isValid != null
                            ? ColorPalette.redBoxBackgroundGradient1
                            : ColorPalette.purpleBoxGradient1)),
                prefixIcon: Icon(
                  icon,
                  color: Colors.white,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: isValid != null
                            ? ColorPalette.redBoxBackgroundGradient1
                            : ColorPalette.purpleBoxGradient1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: isValid != null
                            ? ColorPalette.redBoxBackgroundGradient1
                            : ColorPalette.purpleBoxGradient1)),
                hintText: hintText,
                hintStyle: const TextStyle(color: ColorPalette.white)),
          ),
        )
      ],
    );
  }
}
