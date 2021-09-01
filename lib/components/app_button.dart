import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/enum/app_colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final void Function() onTap;
  const AppButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppColors.buttonBorder,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppText(
              label: label,
              fontColor: AppColors.buttonFontColor,
            ),
          ),
        ),
      ),
    );
  }
}
