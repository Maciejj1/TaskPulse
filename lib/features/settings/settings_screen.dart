import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
        child: SafeArea(
      child: Column(
        children: [
          Center(child: Text("Settings Screen")),
          const Gap(30),
          ElevatedButton(
              onPressed: () => context.read<AuthCubit>().logOut(() => context.go('/login')), child: Text('Wyloguj'))
        ],
      ),
    ));
  }
}
