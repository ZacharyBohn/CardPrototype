import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';

class AppText extends StatelessWidget {
  final String? label;
  const AppText({Key? key, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label ?? '',
      style: TextStyle(
        color: AppColors.fontColor,
        fontSize: 14,
        fontFamily: 'Arial',
      ),
    );
  }
}
