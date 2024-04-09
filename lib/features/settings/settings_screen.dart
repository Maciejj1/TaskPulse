import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/utils/helper/task_pulse_page_screen_builder.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScreenBuilder(
        child: SafeArea(
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
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(children: [
                Text(
                  'Ustawienia',
                  style: TextStyle(color: ColorPalette.darkBlue, fontFamily: 'Poppins', fontSize: 18.sp),
                ),
              ])),
          const Gap(20),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            ColorPalette.yellowBoxBackgroundGradient1,
                            ColorPalette.yellowBoxBackgroundGradient2
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          const Icon(Iconsax.user_edit_outline, color: ColorPalette.white), // Ikona wewnątrz kwadracika
                    ),
                    const Gap(20),
                    SizedBox(
                      width: 150,
                      child: Text(
                        'Zmień swoja nazwe',
                        style: TextStyle(
                          color: ColorPalette.darkBlue,
                          fontSize: 16.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorPalette.darkBlue,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [ColorPalette.greenBoxBackgroundGradient1, ColorPalette.greenBoxBackgroundGradient2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child:
                          const Icon(Icons.mail_lock_outlined, color: ColorPalette.white), // Ikona wewnątrz kwadracika
                    ),
                    const Gap(20),
                    const SizedBox(
                      width: 150,
                      child: Text(
                        'Zmień swój mail',
                        style: TextStyle(
                          color: ColorPalette.darkBlue,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorPalette.darkBlue,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [ColorPalette.blueBoxBackgroundGradient1, ColorPalette.blueBoxBackgroundGradient2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(Iconsax.password_check_outline,
                          color: ColorPalette.white), // Ikona wewnątrz kwadracika
                    ),
                    const Gap(20),
                    const SizedBox(
                      width: 150,
                      child: Text(
                        'Zmień swoje hasło',
                        style: TextStyle(
                          color: ColorPalette.darkBlue,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorPalette.darkBlue,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
          const Gap(20),
          Container(
            height: 55,
            width: MediaQuery.of(context).size.width * 0.9,
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
              color: ColorPalette.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: InkWell(
              onTap: () => context.read<AuthCubit>().logOut(
                    () => context.go('/login'),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        gradient: const LinearGradient(
                          colors: [ColorPalette.redBoxBackgroundGradient1, ColorPalette.redBoxBackgroundGradient2],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Icon(Iconsax.logout_outline, color: ColorPalette.white), // Ikona wewnątrz kwadracika
                    ),
                    const Gap(20),
                    const SizedBox(
                      width: 150,
                      child: Text(
                        'Wyloguj',
                        style: TextStyle(
                          color: ColorPalette.darkBlue,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ]),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorPalette.darkBlue,
                    size: 19,
                  ),
                ],
              ),
            ),
          ),
          const Gap(30),
        ],
      ),
    ));
  }
}
