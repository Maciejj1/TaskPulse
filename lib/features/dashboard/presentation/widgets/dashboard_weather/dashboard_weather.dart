import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_current_city/dashboard_current_city.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_weather/cubit/weather_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_weather/widgets/dashboard_weather_content.dart';

class DashboardWeather extends StatelessWidget {
  const DashboardWeather({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      bloc: context.read<WeatherCubit>()..getWeather(),
      builder: (context, state) {
        return state.when(initial: () {
          return const Text('Initial state');
        }, loading: () {
          return const CircularProgressIndicator();
        }, success: (weather) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              width: double.infinity,
              height: 150.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [ColorPalette.weatherBackgroundGradient1, ColorPalette.weatherBackgroundGradient2],
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      Images.nightIcon,
                      width: 80,
                    ),
                  ),
                  Gap(10.w),
                  const DashboardCurrentCity(),
                  Gap(10.w),
                  DashboardWeatherContent(
                    weather: weather,
                  ),
                ],
              ),
            ),
          );
        }, error: (error) {
          return Text(error);
        });
      },
    );
  }
}
