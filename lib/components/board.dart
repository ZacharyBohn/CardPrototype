import 'package:flutter/material.dart';
import 'package:game_prototype/components/game_card_group_widget.dart';
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
  Matrix4 transformationMatrix = Matrix4.identity()..setEntry(3, 2, 0.001);
  // ..rotateX(-0.75);

  double cardPadding = 6;

  Size getCardSize(Size screenSize, int rows, int columns) {
    double boardWidth = screenSize.width * (1 / 3);
    double boardHeight = screenSize.height * (2 / 3);
    //6 pixels of padding on each side: cardPadding * 2
    double width = (boardWidth / columns) - (cardPadding * 2);
    double height = (boardHeight / rows) - (cardPadding * 2);
    return Size(width, height);
  }

  List<Widget> buildCardRows(BoardProvider boardProvider, Size screenSize) {
    List<Widget> widgets = [];
    int rowPosition = 0;
    int rowCount = boardProvider.board.positions.length;
    int columnCount = boardProvider.board.positions[0].length;
    for (List<GameCardGroupModel> row in boardProvider.board.positions) {
      List<Widget> rowWidgets = [];
      int columnPosition = 0;
      for (GameCardGroupModel cardGroup in row) {
        rowWidgets.add(
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: GameCardGroupWidget(
                rowPosition: rowPosition,
                columnPosition: columnPosition,
                cardSize: getCardSize(screenSize, rowCount, columnCount),
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
    return Transform(
      transform: transformationMatrix,
      alignment: FractionalOffset.center,
      child: Container(
        color: AppColors.board,
        child: Column(
          children: buildCardRows(boardProvider, size),
        ),
      ),
    );
  }
}
