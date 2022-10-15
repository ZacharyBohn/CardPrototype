import 'package:flutter/material.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/components/card_previewer.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';

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
    return boardProvider.highlightedCard == null ||
        boardProvider.previewCards == null ||
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
          width: cardSize.width + 30,
          // show three cards at a time
          height: (cardSize.height * 4) + 5 * 3,
          child: highlightedGroupTooSmall()
              ? null
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (int cardIndex in Iterable.generate(
                          boardProvider.previewCards!.cards.length))
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CardPreviewer(
                            card: boardProvider.previewCards!.cards[cardIndex],
                            cardSize: getCardSize(),
                            highlightColumn: boardProvider.highlightedColumn!,
                            highlightRow: boardProvider.highlightedRow!,
                            cardIndex: cardIndex,
                          ),
                        )
                    ],
                  ),
                ),
        ),
        Spacer(),
      ],
    );
  }
}
