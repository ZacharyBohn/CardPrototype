import 'package:flutter/material.dart';
import 'package:game_prototype/components/game_card_group_widget.dart';
import 'package:game_prototype/enum/app_colors.dart';
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
    int rowCount = boardProvider.rows;
    int columnCount = boardProvider.columns;
    for (var _ in Iterable.generate(rowCount)) {
      List<Widget> rowWidgets = [];
      int columnPosition = 0;
      // ignore: non_constant_identifier_names
      for (var __ in Iterable.generate(columnCount)) {
        rowWidgets.add(
          Flexible(
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: GameCardGroupWidget(
                rowPosition: rowPosition,
                columnPosition: columnPosition,
                cardSize: getCardSize(screenSize, rowCount, columnCount),
                onDraggedFrom: ({
                  required int row,
                  required int column,
                  required moveAllCards,
                }) {
                  if (moveAllCards) {
                    boardProvider.removeCardGroup(row, column);
                    return;
                  }
                  boardProvider.removeTopCard(row, column);
                },
                onDraggedTo: ({
                  required int row,
                  required int column,
                }) {
                  if (Provider.of<BoardProvider>(context, listen: false)
                      .movingAllCards) {
                    boardProvider.addGroupToTop(
                      row,
                      column,
                      boardProvider.movingCardGroup!,
                    );
                  } else {
                    boardProvider.addCardToTop(
                      row,
                      column,
                      boardProvider.movingCardGroup!.topCard!,
                    );
                  }
                  boardProvider.highlightCard(row, column);
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
    if (boardProvider.readingFromDisk) {
      return Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        ),
      );
    }
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
