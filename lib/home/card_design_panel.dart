import 'package:flutter/material.dart';
import 'package:game_prototype/components/app_text.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class CardDesignPanel extends StatefulWidget {
  const CardDesignPanel({Key? key}) : super(key: key);

  @override
  _CardDesignPanelState createState() => _CardDesignPanelState();
}

class _CardDesignPanelState extends State<CardDesignPanel> {
  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    //This widget has 3/11 screen width
    //and 1/1 screen height -app bar
    Size size = MediaQuery.of(context).size;
    Size panelSize = Size(size.width * 3 / 11, size.height);
    return Container(
      color: AppColors.panel,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(label: 'Card Design Panel'),
        ],
      ),
    );
  }
}
