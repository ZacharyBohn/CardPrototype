import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/enum/fonts.dart';

class AppText extends StatelessWidget {
  final String? label;
  final double? fontSize;
  const AppText({Key? key, this.label, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label ?? '',
      style: TextStyle(
        color: AppColors.fontColor,
        fontSize: fontSize ?? FontSizes.body,
        fontFamily: 'Arial',
      ),
    );
  }
}
