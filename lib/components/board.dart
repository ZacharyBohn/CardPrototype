import 'package:flutter/material.dart';
import 'package:game_prototype/components/game_card.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  //TODO: move the transform of the board here to it can be
  //applied to cards when they are being dragged
  List<Widget> buildCardRows(BoardProvider boardProvider, Size cardSize) {
    List<Widget> widgets = [];
    int rowPosition = 0;
    for (List<GameCardGroupModel> row in boardProvider.board.positions) {
      List<Widget> rowWidgets = [];
      int columnPosition = 0;
      for (GameCardGroupModel cardGroup in row) {
        //TODO: conditionally add a card / empty position
        rowWidgets.add(
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(6),
              child: GameCard(
                card: GameCardModel(
                  rowPosition: rowPosition,
                  columPosition: columnPosition,
                ),
                cardSize: cardSize,
                onDraggedFrom: ({required int row, required int column}) {
                  // TODO: implement
                },
                onDraggedTo: (
                    {required GameCardModel cardModel,
                    required int row,
                    required int column}) {
                  // TODO: implement
                },
              ),
            ),
          ),
        );
        columnPosition++;
      }
      widgets.add(
        Flexible(
          child: Row(
            children: rowWidgets,
          ),
        ),
      );
      rowPosition++;
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.board,
      child: Column(
        children: buildCardRows(
          boardProvider,
          Size(size.width * 0.04, size.height * 0.10),
        ),
      ),
    );
  }
}
