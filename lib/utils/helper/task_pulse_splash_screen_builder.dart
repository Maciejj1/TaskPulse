import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/features/auth/presentation/widgets/auth_button.dart';

class TaskPulseSplashScreenBuilder extends StatefulWidget {
  const TaskPulseSplashScreenBuilder({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  _TaskPulseSplashScreenBuilderState createState() => _TaskPulseSplashScreenBuilderState();
}

class _TaskPulseSplashScreenBuilderState extends State<TaskPulseSplashScreenBuilder>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(_controller);
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          SizedBox(
            height: double.maxFinite.h,
            child: Stack(children: [
              Image.asset(
                Images.splash, // Tutaj podaj ścieżkę do swojego zdjęcia
                fit: BoxFit.cover,
              ),
            ]),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Kolor białego tła
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30.r), topRight: Radius.circular(30.r)),
              ),
              height: 420.h,
              child: Column(
                children: [
                  Text('Manage your company\'s tasks with ease'),
                  Text('Zapisuj swoje zadania , ustawia im priorytety i statusy i miej na wszystko oko'),
                  AuthButton(buttonText: 'Get Started', buttonMethod: () => context.go('/login'))
                ],
              ), // Dostosuj wysokość zgodnie z wymaganiami
            ),
          ),
          // Zdjęcie na środku ekranu z animacją
          SingleChildScrollView(
            child: Column(
              children: [
                widget.child!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
