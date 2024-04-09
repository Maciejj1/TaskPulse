import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';
import 'package:task_pulse/features/auth/data/repositories/auth_repository.dart';
import 'package:task_pulse/features/auth/presentation/register/cubit/register_cubit.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_button.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_header.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_password_textfield.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_text_button.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_textfield.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_validate_error.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.white,
      body: SafeArea(
        child: SingleChildScrollView(
            child: BlocProvider(
          create: (_) => RegisterCubit(
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
  String? _nameError;
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conName = TextEditingController();
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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _conEmail.dispose();
    _conPassword.dispose();
    _conName.dispose();
    super.dispose();
  }

  void _validateFields() {
    setState(() {
      _emailError = _emailValidator(_conEmail.text);
      _passwordError = _validatePassword(_conPassword.text);
      _nameError = _validateName(_conName.text);
    });

    if (_emailError == null && _passwordError == null) {
      context
          .read<RegisterCubit>()
          .signUpFormSubmitted(_conName.text, _conEmail.text, _conPassword.text, () => context.go('/dashboard'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const TaskPulseLogoHeader(
          color: ColorPalette.darkBlue,
        ),
        const Gap(60),
        const AuthHeader(
          title: 'Register',
          message: 'Create your account!',
        ),
        const Gap(20),
        AuthTextField(
          header: "Name",
          hintText: "Name",
          icon: Iconsax.user_outline,
          controller: _conName,
        ),
        _nameError != null ? ErrorContainer(errorMessage: _nameError!) : const SizedBox(),
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
        const Gap(20),
        AuthButton(
          buttonText: "Register",
          buttonMethod: () {
            _validateFields();
          },
        ),
        const Gap(10),
        AuthTextButton(
          buttonText: 'You have an account? Login here',
          buttonMethod: () => context.go('/login'),
        )
      ],
    );
  }
}
