import 'package:flutter/material.dart';
import 'package:game_prototype/components/game_card.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  List<Row> buildCardRows(BoardProvider boardProvider) {
    List<Row> widgets = [];
    for (List<GameCardGroupModel> row in boardProvider.board.positions) {
      List<Widget> rowWidgets = [];
      for (GameCardGroupModel cardGroup in row) {
        // rowWidgets.add();
      }
      widgets.add(Row(
        children: rowWidgets,
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    return Container(
      color: AppColors.board,
      child: Column(
        children: buildCardRows(boardProvider),
      ),
    );
  }
}
