import 'package:flutter/material.dart';

class AppColors {
  //colors
  static final Color background = ColorPalette.darkGrey;
  static final Color fontColor = ColorPalette.white;
  static final Color board = ColorPalette.cyan;
  static final Color panel = ColorPalette.cyan;
}

class ColorPalette {
  static final black = Color.fromRGBO(0, 0, 0, 1);
  static final white = Color.fromRGBO(240, 240, 240, 1);
  static final paleWhite = Color.fromRGBO(240, 240, 240, 0.4);
  static final grey = Color.fromRGBO(55, 55, 65, 1);
  static final darkGrey = Color.fromRGBO(50, 50, 60, 1);

  static final cyan = Colors.cyan.shade800;
  static final darkCyan = Colors.cyan.shade900;
  static final lightCyan = Colors.cyan.shade700;
}
