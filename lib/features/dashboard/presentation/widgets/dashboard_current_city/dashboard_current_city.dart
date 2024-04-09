import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_current_city/cubit/current_city_cubit.dart';

class DashboardCurrentCity extends StatelessWidget {
  const DashboardCurrentCity({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentCityCubit, CurrentCityState>(
      bloc: context.read<CurrentCityCubit>()..getCurrentCity(),
      builder: (context, state) {
        return state.when(initial: () {
          return const SizedBox(
            child: Text('Initial'),
          );
        }, loading: () {
          return const SizedBox(
            child: Text('Loading..'),
          );
        }, success: (city) {
          return Flexible(
            child: SizedBox(
              width: 100,
              child: Text(city,
                  style: TextStyle(
                      color: ColorPalette.white, fontSize: 18.sp, fontFamily: 'Poppins', fontWeight: FontWeight.w400)),
            ),
          );
        }, error: (message) {
          return const SizedBox(
            child: Text('Error'),
          );
        });
      },
    );
  }
}
