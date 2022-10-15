import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:provider/provider.dart';

import '../enum/fonts.dart';
import '../models/game_card.model.dart';
import '../providers/board_provider.dart';
import 'app_text.dart';

class CardPreviewer extends StatelessWidget {
  final Size cardSize;
  final GameCardModel card;
  final int cardIndex;
  final int highlightRow;
  final int highlightColumn;
  const CardPreviewer({
    Key? key,
    required this.card,
    required this.cardIndex,
    required this.cardSize,
    required this.highlightRow,
    required this.highlightColumn,
  }) : super(key: key);

  Widget getCardImage() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (card.hasImage)
          Expanded(
            child: Image.network(
              card.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, _, __) {
                return AppText(label: '[Image Error]');
              },
            ),
          ),
        Center(
          child: AppText(
            label: card.name.isNotEmpty ? card.name : '?',
            fontSize: FontSizes.small,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var boardProvider = context.watch<BoardProvider>();
    return Material(
      child: Draggable(
        onDragStarted: () {
          boardProvider.movingCardGroup = GameCardGroupModel(
            rowPosition: -99,
            columnPosition: -99,
            cards: [card],
          );
          return;
        },
        onDragEnd: (_) {
          boardProvider.removeCardFromGroup(
            column: highlightColumn,
            row: highlightRow,
            cardIndex: cardIndex,
          );
          return;
        },
        data: GameCardGroupModel(
          rowPosition: -99,
          columnPosition: -99,
          cards: [card],
        ),
        // don't show anything when dragging
        childWhenDragging: Container(),
        maxSimultaneousDrags: 1,
        //card that is dragged
        feedback: Material(
          child: Container(
            width: cardSize.width * 1.2,
            height: cardSize.height * 1.1,
            decoration: BoxDecoration(
              color: AppColors.cardForeground,
            ),
            child: getCardImage(),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            // TODO: this won't work, need to change this card
            // manually and check for reprocussions
            boardProvider.highlightCard(
              highlightRow,
              highlightColumn,
            );
            return;
          },
          //stationary card
          child: Container(
            width: cardSize.width.ceilToDouble(),
            height: cardSize.height.ceilToDouble(),
            decoration: BoxDecoration(
              color: AppColors.cardForeground,
            ),
            child: getCardImage(),
          ),
        ),
      ),
    );
  }
}
