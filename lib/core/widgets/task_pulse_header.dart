import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_pulse/core/resources/color_palette.dart';
import 'package:task_pulse/core/resources/images.dart';
import 'package:task_pulse/core/widgets/task_pulse_logo_header.dart';

class TaskPulseHeader extends StatelessWidget {
  const TaskPulseHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
