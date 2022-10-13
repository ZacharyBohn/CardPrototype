import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/enum/fonts.dart';

class AppText extends StatelessWidget {
  final String? label;
  final double? fontSize;
  final Color? fontColor;
  final TextAlign? textAlign;
  final FontStyle? fontStyle;
  final bool singleLine;
  const AppText({
    Key? key,
    this.label,
    this.fontSize,
    this.fontColor,
    this.textAlign,
    this.fontStyle,
    this.singleLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label ?? '',
      textAlign: textAlign,
      maxLines: singleLine ? 1 : null,
      style: TextStyle(
        color: fontColor ?? AppColors.fontColor,
        fontSize: fontSize ?? FontSizes.body,
        fontFamily: 'Arial',
        fontStyle: fontStyle,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
