import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/dashboard/presentation/widgets/dashboard_profile/cubit/profile_cubit.dart';

class DashboardProfile extends StatelessWidget {
  const DashboardProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: context.read<ProfileCubit>()..getProfile(),
      builder: (context, state) {
        return state.when(
          initial: () {
            // Handle initial state
            return const Text('Initial state');
          },
          loading: () {
            // Handle loading state
            return const CircularProgressIndicator();
          },
          success: (user) {
            // Handle success state
            return Padding(
              padding: const EdgeInsets.only(left: 20),
              child: SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Hello, ${user.name}',
                            style: TextStyle(
                                color: ColorPalette.darkBlue,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w700,
                                fontSize: 27.sp))
                      ],
                    ),
                    Row(
                      children: [
                        Text('Have a nice day',
                            style: TextStyle(
                                color: ColorPalette.grey,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp))
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          error: (message) {
            // Handle error state
            return Text(message);
          },
        );
      },
    );
  }
}
