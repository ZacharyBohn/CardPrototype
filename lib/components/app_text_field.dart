import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final String? initialText;
  final void Function(String)? onTextChange;
  const AppTextField({
    Key? key,
    this.initialText,
    this.onTextChange,
  }) : super(key: key);

  @override
  _AppTextFieldState createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late TextEditingController controller;

  @override
  initState() {
    controller = TextEditingController(text: widget.initialText);
    super.initState();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (String value) {
        widget.onTextChange?.call(value);
      },
    );
  }
}
