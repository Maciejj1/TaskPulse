// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class AuthPasswordTextField extends StatefulWidget {
  const AuthPasswordTextField({super.key, required this.controller, this.validator, this.isValid});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String? isValid;

  @override
  _AuthPasswordTextFieldState createState() => _AuthPasswordTextFieldState();
}

class _AuthPasswordTextFieldState extends State<AuthPasswordTextField> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 300.w,
          child: Row(
            children: [
              Text(
                'Password',
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
            validator: widget.validator,
            controller: widget.controller,
            style: TextStyle(color: ColorPalette.weatherBackgroundGradient1, fontSize: 14.sp, fontFamily: 'Inter'),
            obscureText: _obscurePassword,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              fillColor: ColorPalette.weatherBackgroundGradient1,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: widget.isValid != null
                          ? ColorPalette.redBoxBackgroundGradient1
                          : ColorPalette.weatherBackgroundGradient1)),
              prefixIcon: const Icon(
                Icons.key,
                color: ColorPalette.weatherBackgroundGradient1,
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: widget.isValid != null
                          ? ColorPalette.redBoxBackgroundGradient1
                          : ColorPalette.weatherBackgroundGradient1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                      color: widget.isValid != null
                          ? ColorPalette.redBoxBackgroundGradient1
                          : ColorPalette.weatherBackgroundGradient1)),
              hintText: "Password",
              hintStyle: const TextStyle(
                color: ColorPalette.weatherBackgroundGradient1,
              ),
              suffixIcon: IconButton(
                color: ColorPalette.weatherBackgroundGradient1,
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
