import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/enum/fonts.dart';

class AppTextField extends StatefulWidget {
  final String? hint;
  final String? initialText;
  final double? fontSize;
  final TextEditingController? controller;
  final void Function(String)? onTextChange;
  final bool oneLine;
  const AppTextField({
    Key? key,
    this.hint,
    this.initialText,
    this.fontSize,
    this.controller,
    this.onTextChange,
    this.oneLine = true,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController controller;

  @override
  initState() {
    controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
    super.initState();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      textCapitalization: TextCapitalization.none,
      maxLines: widget.oneLine ? 1 : null,
      onChanged: (String value) {
        widget.onTextChange?.call(value);
      },
      style: TextStyle(
        color: AppColors.fontColor,
        fontSize: widget.fontSize ?? FontSizes.body,
        fontFamily: 'Arial',
      ),
      cursorColor: AppColors.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: TextStyle(
          color: AppColors.hintFontColor,
          fontSize: widget.fontSize ?? FontSizes.body,
          fontFamily: 'Arial',
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textInputUnderline,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textInputUnderlineFocused,
          ),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textInputUnderline,
          ),
        ),
      ),
    );
  }
}
