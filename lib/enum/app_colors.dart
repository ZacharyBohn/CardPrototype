import 'package:flutter/material.dart';

class AppColors {
  //colors
  static final Color background = ColorPalette.darkGrey;
  static final Color fontColor = ColorPalette.white;
  static final Color board = ColorPalette.cyan;
  static final Color panel = ColorPalette.cyan;
  static final Color emptyPositionHighlighted = ColorPalette.paleWhite;
  static final Color cardBackground = ColorPalette.darkGrey;
  static final Color cardBack = ColorPalette.purple;
}

class ColorPalette {
  static final white = Color.fromRGBO(240, 240, 240, 1);
  static final paleWhite = Color.fromRGBO(240, 240, 240, 0.4);
  static final grey = Color.fromRGBO(55, 55, 65, 1);
  static final darkGrey = Color.fromRGBO(50, 50, 60, 1);
  static final black = Color.fromRGBO(0, 0, 0, 1);

  static final lightCyan = Color.fromRGBO(0, 135, 120, 1);
  static final cyan = Color.fromRGBO(0, 115, 100, 1);
  static final darkCyan = Color.fromRGBO(0, 95, 80, 1);

  static final purple = Color.fromRGBO(60, 5, 60, 1);
}
