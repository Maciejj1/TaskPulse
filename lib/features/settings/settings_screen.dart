import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/widgets/task_pulse_header.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/settings/widgets/cubit/settings_cubit.dart';
import 'package:task_pulse/features/settings/widgets/settings_button.dart';
import 'package:task_pulse/features/settings/widgets/settings_dialog_content.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
        child: SafeArea(
      child: Column(
        children: [
          const TaskPulseHeader(),
          const Gap(20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Text(
                  'Settings',
                  style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 18.sp),
                ),
              ])),
          const Gap(20),
          SettingsButton(
            colors: const [ColorPalette.yellowBoxBackgroundGradient1, ColorPalette.yellowBoxBackgroundGradient2],
            icon: Iconsax.user_edit_outline,
            buttonName: 'Change your name',
            buttonMethod: () {
              _openNameForm(context);
            },
          ),
          const Gap(20),
          SettingsButton(
            colors: const [ColorPalette.greenBoxBackgroundGradient1, ColorPalette.greenBoxBackgroundGradient2],
            icon: Icons.mail_lock_outlined,
            buttonName: 'Change your email',
            buttonMethod: () {
              _openEmailForm(context);
            },
          ),
          const Gap(20),
          SettingsButton(
            colors: const [ColorPalette.blueBoxBackgroundGradient1, ColorPalette.blueBoxBackgroundGradient2],
            icon: Iconsax.password_check_outline,
            buttonName: 'Change your password',
            buttonMethod: () {
              _showPasswordChangeDialog(context);
            },
          ),
          const Gap(20),
          SettingsButton(
            colors: const [ColorPalette.redBoxBackgroundGradient1, ColorPalette.redBoxBackgroundGradient2],
            icon: Iconsax.logout_outline,
            buttonName: 'Logout',
            buttonMethod: () => context.read<AuthCubit>().logOut(
                  () => context.go('/login'),
                ),
          ),
        ],
      ),
    ));
  }

  void _showPasswordChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SettingsDialogContent(
          formatter: const [],
          textInputType: TextInputType.name,
          buttonMethod: () {
            if (_passwordController.text.isEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'You must fill in all the fields!',
                ),
              );
            } else if (_passwordController.text.length < 5 && _passwordController.text.isNotEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'Your password must not be less than 5 characters long',
                ),
              );
            } else {
              context.read<AuthCubit>().changePassword(_passwordController.text);
              context.read<SettingsCubit>().changePassword(_passwordController.text);
              AuthRepository().changePassword(_passwordController.text);
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(
                  message: 'Successfully changed the password',
                ),
              );

              Navigator.of(context).pop();
            }
          },
          dialogTitle: 'Change Password',
          obscureText: _obscurePassword,
          icon: Iconsax.password_check_outline,
          controller: _passwordController,
          hintText: 'New password',
        );
      },
    );
  }

  void _openEmailForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        const pattern = r"(?:[a-z0-9!#//$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
            r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
            r'\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
            r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
            r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
            r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
            r'x21-\x5a\x53-\x7f]|\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
        final regex = RegExp(pattern);
        return SettingsDialogContent(
          formatter: const [],
          textInputType: TextInputType.emailAddress,
          buttonMethod: () {
            if (_emailController.text.isEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'You must fill in all the fields!',
                ),
              );
            } else if (!regex.hasMatch(_emailController.text) && _emailController.text.isNotEmpty) {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.info(
                  message: 'Your password must not be less than 5 characters long',
                ),
              );
            } else {
              context.read<AuthCubit>().changeEmail(_emailController.text);
              context.read<SettingsCubit>().changeEmail(_emailController.text);

              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(
                  message: 'Successfully changed the mail',
                ),
              );
              Navigator.of(context).pop();
            }
          },
          dialogTitle: 'Change email',
          obscureText: false,
          icon: Icons.mail_lock_outlined,
          controller: _emailController,
          hintText: 'New email',
        );
      },
    );
  }

  void _openNameForm(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SettingsDialogContent(
            formatter: const [],
            textInputType: TextInputType.name,
            buttonMethod: () {
              if (_nameController.text.isEmpty) {
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: 'You must fill in all the fields!',
                  ),
                );
              } else {
                context.read<SettingsCubit>().changeName(_nameController.text);
                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.success(
                    message: 'Successfully changed the mail',
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            dialogTitle: 'Change name',
            obscureText: false,
            icon: Iconsax.user_outline,
            controller: _nameController,
            hintText: 'New name');
      },
    );
  }
}
