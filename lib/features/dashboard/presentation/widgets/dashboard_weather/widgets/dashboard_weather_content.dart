import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/data/models/weather_response.dart';

class DashboardWeatherContent extends StatelessWidget {
  const DashboardWeatherContent({
    super.key,
    required this.weather,
  });
  final WeatherResponse weather;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(DateFormat('EEEE | MMM dd').format(DateTime.now()),
              style: TextStyle(
                  color: ColorPalette.white, fontSize: 14.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
          Gap(5.h),
          Text('${weather.main!.temp!.toInt()}°C',
              style: TextStyle(
                  color: ColorPalette.white, fontSize: 25.sp, fontFamily: 'Poppins', fontWeight: FontWeight.bold)),
          Text(weather.weather!.first.description ?? 'N/A',
              style: TextStyle(
                  color: ColorPalette.white, fontSize: 14.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400))
        ],
      ),
    );
  }
}
