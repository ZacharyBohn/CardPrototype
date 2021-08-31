import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/enum/app_colors.dart';

class PreviewPanel extends StatefulWidget {
  const PreviewPanel({Key? key}) : super(key: key);

  @override
  _PreviewPanelState createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.panel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(label: 'Card Preview Panel'),
        ],
      ),
    );
  }
}
