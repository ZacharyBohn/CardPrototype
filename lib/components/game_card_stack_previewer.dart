import 'package:flutter/material.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/components/game_card_group_widget.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

import '../models/game_card.model.dart';

class GameCardStackPreviewer extends StatefulWidget {
  const GameCardStackPreviewer({Key? key}) : super(key: key);

  @override
  State<GameCardStackPreviewer> createState() => _GameCardStackPreviewerState();
}

class _GameCardStackPreviewerState extends State<GameCardStackPreviewer> {
  Size getCardSize() {
    var provider = context.read<BoardProvider>();
    Size cardSize = BoardState.getCardSize(
      MediaQuery.of(context).size,
      provider.rows,
      provider.columns,
    );
    return cardSize;
  }

  bool highlightedGroupTooSmall() {
    var boardProvider = context.read<BoardProvider>();
    return boardProvider.previewCards == null ||
        boardProvider
                .getCardGroup(boardProvider.highlightedRow!,
                    boardProvider.highlightedColumn!)
                .cards
                .length <
            2;
  }

  @override
  Widget build(BuildContext context) {
    var boardProvider = context.watch<BoardProvider>();
    Size cardSize = getCardSize();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          color: AppColors.cardPreviewerBackground,
          width: cardSize.width + 10,
          // show three cards at a time
          height: (cardSize.height * 3) + 5 * 3,
          child: highlightedGroupTooSmall()
              ? null
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int cardIndex in Iterable.generate(
                          boardProvider.previewCards!.cards.length))
                        // create one of these for each card in the group
                        // create a game card group model constructor that takes
                        // a single game card and creates a group from it
                        // the row / column of each of these will be just the
                        // highlighted group's row / column
                        // will need to create a param to disable dragging
                        // groups.
                        //
                        // maybe do something to pass in the game card group model?
                        GameCardGroupWidget(
                          rowPosition: cardIndex,
                          columnPosition: boardProvider.highlightedColumn!,
                          cardSize: cardSize,
                          disableMovingAllCards: true,
                          canDragTo: false,
                          onDraggedFrom: ({
                            required int row,
                            required int column,
                            required moveAllCards,
                          }) {
                            // remove the card that has dragged from the stack
                            return;
                          },
                          onDraggedTo: ({
                            required int row,
                            required int column,
                          }) {
                            // add the dragged card to the row / column that is
                            // was dragged to, then highlight it
                            return;
                          },
                        ),
                    ],
                  ),
                ),
        ),
        Spacer(),
      ],
    );
  }
}
