import 'package:flutter/material.dart';
import 'package:task_pulse/core/resources/color_palette.dart';

class TaskStyles {
  TaskStyles._();
  static String? getTextForTaskStatus(int? taskStatus) {
    switch (taskStatus) {
      case 1:
        return 'Done'; // Tekst dla "done"
      case 2:
        return 'Planned'; // Tekst dla "planned"
      case 3:
        return 'In Review'; // Tekst dla "in review"
      case 4:
        return 'Executing'; // Tekst dla "executing"
      default:
        return null; // Domyślny tekst
    }
  }

  static Color getColorForTaskStatus(int? taskStatus) {
    switch (taskStatus) {
      case 1:
        return ColorPalette.greenBoxBackgroundGradient2; // Zielony dla "done"
      case 2:
        return ColorPalette.yellowBoxBackgroundGradient2; // Żółty dla "planned"
      case 3:
        return ColorPalette.blueBoxBackgroundGradient2; // Niebieski dla "in review"
      case 4:
        return ColorPalette.redBoxBackgroundGradient2; // Czerwony dla "executing"
      default:
        return Colors.black; // Domyślny kolor
    }
  }

  static Color getColorForTaskStatusBackground(int? taskStatus) {
    switch (taskStatus) {
      case 1:
        return ColorPalette.greenBoxBackgroundGradient1.withOpacity(0.5); // Zielony dla "done"
      case 2:
        return ColorPalette.yellowBoxBackgroundGradient1.withOpacity(0.5); // Żółty dla "planned"
      case 3:
        return ColorPalette.blueBoxBackgroundGradient1.withOpacity(0.5); // Niebieski dla "in review"
      case 4:
        return ColorPalette.redBoxBackgroundGradient1.withOpacity(0.5); // Czerwony dla "executing"
      default:
        return Colors.black; // Domyślny kolor
    }
  }
}
