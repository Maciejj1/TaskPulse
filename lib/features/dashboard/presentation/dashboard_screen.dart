import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/dashboard_profile.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

import 'widgets/dashboard_weather/dashboard_weather.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
        child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  child: TaskPulseLogoHeader(
                    color: ColorPalette.darkBlue,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    Images.userAvatar,
                    width: 50,
                    height: 50,
                  ),
                )
              ],
            ),
            const Gap(20),
            const DashboardProfile(),
            const Gap(20),
            const DashboardWeather(),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 110.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorPalette.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      child: Text(
                        'All Tasks',
                        style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: ColorPalette.blueBoxBackgroundGradient1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      child: Text(
                        'Priority High',
                        style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 130.w,
                    height: 45.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shadowColor: Colors.transparent,
                        backgroundColor: ColorPalette.blueBoxBackgroundGradient1,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                      ),
                      child: Text(
                        'Priority Low',
                        style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 12.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: 180.w,
                                    height: 170.h,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            ColorPalette.greenBoxBackgroundGradient1,
                                            ColorPalette.greenBoxBackgroundGradient2
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('22',
                                            style: TextStyle(
                                                color: ColorPalette.white,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600)),
                                        Text('Done', style: TextStyle(color: ColorPalette.white, fontSize: 16.sp))
                                      ],
                                    ),
                                  ),
                                  const Gap(20),
                                  Container(
                                    width: 180.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            ColorPalette.redBoxBackgroundGradient1,
                                            ColorPalette.redBoxBackgroundGradient2
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('22',
                                            style: TextStyle(
                                                color: ColorPalette.white,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600)),
                                        Text('Done', style: TextStyle(color: ColorPalette.white, fontSize: 16.sp))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(20),
                              Column(
                                children: [
                                  Container(
                                    width: 180.w,
                                    height: 120.h,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            ColorPalette.yellowBoxBackgroundGradient1,
                                            ColorPalette.yellowBoxBackgroundGradient2
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('22',
                                            style: TextStyle(
                                                color: ColorPalette.white,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600)),
                                        Text('Done', style: TextStyle(color: ColorPalette.white, fontSize: 16.sp))
                                      ],
                                    ),
                                  ),
                                  const Gap(20),
                                  Container(
                                    width: 180.w,
                                    height: 170.h,
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            ColorPalette.blueBoxBackgroundGradient1,
                                            ColorPalette.blueBoxBackgroundGradient2
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('22',
                                            style: TextStyle(
                                                color: ColorPalette.white,
                                                fontSize: 30.sp,
                                                fontWeight: FontWeight.w600)),
                                        Text('Done', style: TextStyle(color: ColorPalette.white, fontSize: 16.sp))
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
