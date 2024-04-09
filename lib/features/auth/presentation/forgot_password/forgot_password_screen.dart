import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_header.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static Page<void> page() => const MaterialPage<void>(child: ForgotPasswordScreen());
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ForgotPasswordScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<AuthCubit>(
                create: (_) => AuthCubit(
                  AuthRepository(),
                ),
              ),
            ],
            child: const ForgotPasswordForm(),
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final conEmail = TextEditingController();

    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        children: [
          const TaskPulseLogoHeader(
            color: ColorPalette.darkBlue,
          ),
          const Gap(90),
          const AuthHeader(
            title: 'Forgot Password?',
            message: 'Write mail and send reset link!',
          ),
          const Gap(60),
          AuthTextField(
            header: "Email",
            hintText: "Email",
            icon: Icons.mail,
            controller: conEmail,
          ),
          const Gap(60),
          ResetPasswordButton(
            controller: conEmail,
          ),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  context.go('/login');
                },
                child: const Text('Wróć do Logowania', style: TextStyle(color: ColorPalette.darkBlue)),
              ),
            ],
          ),
        ],
      );
    });
  }
}

class LoginEmailTextField extends StatelessWidget {
  const LoginEmailTextField({super.key, required this.conEmail});
  final TextEditingController conEmail;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            height: 50,
            child: TextFormField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: conEmail,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.mail),
                hintText: "Email",
              ),
            ),
          )
        ],
      );
    });
  }
}

class ResetPasswordButton extends StatelessWidget {
  const ResetPasswordButton({Key? key, required this.controller}) : super(key: key);
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Container(
          width: 200.w,
          height: 45.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [ColorPalette.blueBoxBackgroundGradient1, ColorPalette.blueBoxBackgroundGradient2],
              )),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: () async {
              try {
                if (controller.text.isEmpty) {
                  throw FirebaseAuthException(code: 'missing-email', message: 'Adres email musi zostać podany.');
                }
                final bool isEmailValid =
                    RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(controller.text);
                if (!isEmailValid) {
                  throw FirebaseAuthException(code: 'invalid-email', message: 'Nieprawidłowy format adresu e-mail.');
                }
                await context.read<AuthCubit>().resetPassword(controller.text);

                showTopSnackBar(
                  Overlay.of(context),
                  const CustomSnackBar.info(
                    message: 'Link do resetowania hasła został wysłany.',
                  ),
                );
              } on FirebaseAuthException catch (e) {
                if (controller.text.isNotEmpty && e.code == 'invalid-email') {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(
                      message: 'Wpisałeś zły mail.',
                    ),
                  );
                } else if (e.code == 'user-not-found') {
                  // User not found
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(
                      message: 'Nie ma takiego użytkownika',
                    ),
                  );
                } else if (e.code == 'missing-email') {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(
                      message: 'Nic nie wpisałeś.',
                    ),
                  );
                } else {
                  // Other errors
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.info(
                      message: 'Coś się popsuło. Spróbuj ponownie.',
                    ),
                  );
                }
              }
            },
            child: Text(
              'Przypomnij hasło',
              style: TextStyle(color: ColorPalette.white, fontFamily: 'Poppins', fontSize: 16.sp),
            ),
          ),
        );
      },
    );
  }
}
