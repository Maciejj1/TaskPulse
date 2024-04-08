import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/login/cubit/auth_cubit.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_header.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_password_textfield.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_validate_error.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocProvider(
          create: (_) => AuthCubit(
            AuthRepository(),
          ),
          child: const LoginScreenForm(),
        )),
      ),
    );
  }
}

class LoginScreenForm extends StatefulWidget {
  const LoginScreenForm({super.key});

  @override
  State<LoginScreenForm> createState() => _LoginScreenFormState();
}

class _LoginScreenFormState extends State<LoginScreenForm> {
  String? _emailError;
  String? _passwordError;
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }
    return null;
  }

  @override
  void dispose() {
    _conEmail.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _emailError = _emailValidator(_conEmail.text);
      _passwordError = _validatePassword(_conPassword.text);
    });

    if (_emailError == null && _passwordError == null) {
      context.read<AuthCubit>().singInFormSubmitted(_conEmail.text, _conPassword.text, () => context.go('/dashboard'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Gap(90),
          const AuthHeader(
            title: 'Hi, Welcome Back!',
            message: 'Hello again, you’ve been missed!',
          ),
          const Gap(20),
          AuthTextField(
            header: "Email",
            hintText: "Email",
            icon: Icons.mail,
            controller: _conEmail,
          ),
          _emailError != null ? ErrorContainer(errorMessage: _emailError!) : const SizedBox(),
          const Gap(20),
          AuthPasswordTextField(
            controller: _conPassword,
          ),
          _passwordError != null ? ErrorContainer(errorMessage: _passwordError!) : const SizedBox(),
          SizedBox(
            width: 310.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: ColorPalette.deepPurple,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400),
                    ))
              ],
            ),
          ),
          const Gap(10),
          AuthButton(
              buttonText: "Login",
              buttonMethod: () {
                _validateFields();
              }),
          const Gap(20),
          AuthTextButton(
            buttonText: 'Not have an account? Register here',
            buttonMethod: () => context.go('/register'),
          )
        ]);
  }
}
