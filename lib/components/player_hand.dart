import 'package:flutter/material.dart';
import 'package:game_prototype/components/game_card_group_widget.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

class PlayerHand extends StatefulWidget {
  final bool isPlayer1;
  const PlayerHand({
    Key? key,
    required this.isPlayer1,
  }) : super(key: key);

  @override
  _PlayerHandState createState() => _PlayerHandState();
}

class _PlayerHandState extends State<PlayerHand> {
  double cardPadding = 6;

  Size getCardSize(Size screenSize, int rows, int columns) {
    double boardWidth = screenSize.width * (1 / 3);
    double boardHeight = screenSize.height * (2 / 3);
    //6 pixels of padding on each side: cardPadding * 2
    double width = (boardWidth / columns) - (cardPadding * 2);
    double height = (boardHeight / rows) - (cardPadding * 2);
    return Size(width, height);
  }

  List<Widget> buildCardRow(BoardProvider boardProvider, Size screenSize) {
    List<Widget> widgets = [];
    int rowPosition = widget.isPlayer1 ? boardProvider.rows : -1;
    int columnCount = boardProvider.columns;
    for (var columnPosition in Iterable.generate(columnCount)) {
      widgets.add(
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(cardPadding),
            child: GameCardGroupWidget(
              alwaysFaceUp: true,
              onlyOneCard: true,
              rowPosition: rowPosition,
              columnPosition: columnPosition,
              cardSize:
                  getCardSize(screenSize, boardProvider.rows, columnCount),
              onDraggedFrom: ({
                required int row,
                required int column,
                required bool moveAllCards,
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
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: AppColors.handArea,
      child: Row(
        children: buildCardRow(boardProvider, size),
      ),
    );
  }
}
