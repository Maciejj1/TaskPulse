import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class TaskSearchTextField extends StatelessWidget {
  const TaskSearchTextField({super.key, required this.searchController, this.onChanged});
  final TextEditingController searchController;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 40.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorPalette.white),
          child: TextFormField(
            controller: searchController,
            onChanged: onChanged,
            textAlignVertical: TextAlignVertical.top,
            style: TextStyle(color: ColorPalette.darkBlue, fontSize: 14.sp, fontFamily: 'Inter'),
            decoration: InputDecoration(
                border: InputBorder.none,
                focusColor: ColorPalette.weatherBackgroundGradient1,
                errorStyle:
                    TextStyle(color: ColorPalette.weatherBackgroundGradient1, fontSize: 14.sp, fontFamily: 'Inter'),
                fillColor: ColorPalette.weatherBackgroundGradient1,
                prefixIcon: const Icon(
                  Iconsax.search_normal_outline,
                  color: ColorPalette.darkBlue,
                ),
                hintText: 'Search by name',
                hintStyle: const TextStyle(color: ColorPalette.darkBlue)),
          ),
        ),
      ),
    );
  }
}
