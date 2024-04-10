import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({
    super.key,
    required this.colors,
    required this.icon,
    required this.buttonName,
    required this.buttonMethod,
  });
  final List<Color> colors;
  final IconData icon;
  final String buttonName;
  final Function buttonMethod;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.9,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () => buttonMethod(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    colors: colors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Icon(icon, color: ColorPalette.white), // Ikona wewnątrz kwadracika
              ),
              const Gap(20),
              SizedBox(
                width: 150,
                child: Text(
                  buttonName,
                  style: TextStyle(
                    color: ColorPalette.darkBlue,
                    fontSize: 16.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ]),
            Icon(
              Icons.arrow_forward_ios,
              color: ColorPalette.darkBlue,
              size: 19,
            ),
          ],
        ),
      ),
    );
  }
}
