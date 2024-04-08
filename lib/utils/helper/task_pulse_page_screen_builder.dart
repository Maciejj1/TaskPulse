import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:awesome_bottom_bar/widgets/inspired/inspired.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class PageScreenBuilder extends StatelessWidget {
  const PageScreenBuilder({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const ConnectifyBottomNav(),
        backgroundColor: Colors.transparent,
        body:
            Container(width: double.maxFinite, color: const Color(0xFFE6EEFA), height: double.maxFinite, child: child));
  }
}

List<TabItem> items = [
  const TabItem(
    icon: Iconsax.home_2_outline,
    title: 'Dashboard',
  ),
  const TabItem(
    icon: Iconsax.calendar_1_outline,
    title: 'Tasks',
  ),
  const TabItem(
    icon: Iconsax.setting_2_outline,
    title: 'Settings',
  ),
];

class ConnectifyBottomNav extends StatefulWidget {
  const ConnectifyBottomNav({Key? key}) : super(key: key);

  @override
  State<ConnectifyBottomNav> createState() => _ConnectifyBottomNavState();
}

class _ConnectifyBottomNavState extends State<ConnectifyBottomNav> {
  int visit = 0;

  @override
  Widget build(BuildContext context) {
    return BottomBarInspiredOutside(
      items: items,
      backgroundColor: ColorPalette.deepPurple,
      color: ColorPalette.white,
      colorSelected: ColorPalette.white,
      indexSelected: _calculateSelectedIndex(context),
      onTap: onTap,
      top: -25,
      animated: true,
      itemStyle: ItemStyle.hexagon,
      chipStyle: const ChipStyle(notchSmoothness: NotchSmoothness.verySmoothEdge),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.routerDelegate.currentConfiguration.fullPath;
    if (location.startsWith('/dashboard')) {
      return 0;
    }
    // if (location.startsWith('/events')) {
    //   return 1;
    // }
    if (location.startsWith('/tasks')) {
      return 1;
    }
    // if (location.startsWith('/ranking')) {
    //   return 3;
    // }
    if (location.startsWith('/settings')) {
      return 2;
    }
    return 0;
  }

  void onTap(int value) {
    switch (value) {
      case 0:
        return context.go('/dashboard');
      // case 1:
      //   return context.go('/events');
      case 1:
        return context.go('/tasks');
      // case 3:
      //   return context.go('/ranking');
      case 2:
        return context.go('/setting');
      default:
        return context.go('/dashboard');
    }
  }
}
