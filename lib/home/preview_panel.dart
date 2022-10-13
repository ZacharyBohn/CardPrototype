import 'package:flutter/material.dart';
import 'package:game_prototype/components/card_preview.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class PreviewPanel extends StatefulWidget {
  const PreviewPanel({Key? key}) : super(key: key);

  @override
  _PreviewPanelState createState() => _PreviewPanelState();
}

class _PreviewPanelState extends State<PreviewPanel> {
  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    //This widget has 3/11 screen width
    //and 1/1 screen height -app bar
    Size size = MediaQuery.of(context).size;
    Size panelSize = Size(size.width * 3 / 11, size.height * 0.93);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.panel,
        border: Border(
          right: BorderSide(
            width: 1,
            color: AppColors.panelBarrier,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CardPreview(
              width: panelSize.width * 0.85,
              height: panelSize.height * 0.65,
              card: boardProvider.highlightedCard,
            ),
          ),
        ],
      ),
    );
  }
}
