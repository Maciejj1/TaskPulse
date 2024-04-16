import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/resources/color_palette.dart';

class DashboardTabs extends StatelessWidget {
  const DashboardTabs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.maxFinite.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: SegmentedTabControl(
                        radius: const Radius.circular(20),
                        backgroundColor: ColorPalette.weatherBackgroundGradient1,
                        indicatorColor: Colors.orange.shade200,
                        tabTextColor: ColorPalette.white,
                        selectedTabTextColor: ColorPalette.darkBlue,
                        squeezeIntensity: 2,
                        height: 40.h,
                        tabPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        tabs: const [
                          SegmentTab(label: 'All tasks', color: ColorPalette.white),
                          SegmentTab(label: 'High priority', color: ColorPalette.white),
                          SegmentTab(label: 'Low priority', color: ColorPalette.white),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
