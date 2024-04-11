import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class SettingsDialogContent extends StatelessWidget {
  const SettingsDialogContent(
      {super.key,
      required this.buttonMethod,
      required this.dialogTitle,
      required this.obscureText,
      this.controller,
      required this.icon,
      required this.hintText,
      required this.textInputType,
      required this.formatter});
  final Function buttonMethod;
  final String dialogTitle;
  final bool obscureText;
  final TextEditingController? controller;
  final IconData icon;
  final String hintText;
  final TextInputType textInputType;
  final List<TextInputFormatter> formatter;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(color: ColorPalette.white, borderRadius: BorderRadius.circular(15)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
              dialogTitle,
              style: TextStyle(color: ColorPalette.weatherBackgroundGradient1, fontFamily: 'Poppins', fontSize: 20.sp),
            )),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.7,
                child: TextFormField(
                  inputFormatters: formatter,
                  keyboardType: textInputType,
                  textAlignVertical: TextAlignVertical.bottom,
                  obscureText: obscureText, // Hide or show password based on this flag
                  controller: controller,
                  style:
                      TextStyle(color: ColorPalette.weatherBackgroundGradient1, fontSize: 16.sp, fontFamily: 'Inter'),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      icon,
                      color: ColorPalette.weatherBackgroundGradient1,
                    ),
                    hintText: hintText,
                  ),
                ),
              ),
            ),
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel', style: TextStyle(color: ColorPalette.redBoxBackgroundGradient2)),
                ),
                TextButton(
                  onPressed: () => buttonMethod(),
                  child: const Text('Change', style: TextStyle(color: ColorPalette.weatherBackgroundGradient1)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
