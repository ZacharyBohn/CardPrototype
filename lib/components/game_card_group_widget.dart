import 'package:flutter/material.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';
import '../enum/app_colors.dart';
import '../models/game_card.model.dart';
import 'app_text.dart';

class GameCardGroupWidget extends StatefulWidget {
  final int rowPosition;
  final int columnPosition;
  final Size cardSize;
  final bool alwaysFaceUp;
  final bool onlyOneCard;
  final void Function({
    required int row,
    required int column,
  }) onDraggedFrom;
  final void Function({
    required int row,
    required int column,
    required GameCardModel cardModel,
  }) onDraggedTo;
  final void Function(int)? onPopupItemSelected;
  const GameCardGroupWidget({
    required this.rowPosition,
    required this.columnPosition,
    required this.cardSize,
    required this.onDraggedFrom,
    required this.onDraggedTo,
    this.onPopupItemSelected,
    this.alwaysFaceUp = false,
    this.onlyOneCard = false,
  });

  @override
  _GameCardGroupWidgetState createState() => _GameCardGroupWidgetState();
}

class _GameCardGroupWidgetState extends State<GameCardGroupWidget> {
  double borderRadius = 0.0;

  Color getCardColor(GameCardModel? topCard) {
    if (topCard == null) {
      return AppColors.emptyPosition;
    }
    if (topCard.faceup || widget.alwaysFaceUp) {
      return AppColors.cardForeground;
    }
    if (!topCard.faceup) {
      return AppColors.cardBack;
    }
    throw Exception('No color?');
  }

  Widget? getCardImage(GameCardModel? topCard) {
    if (topCard == null) return Container();
    if (topCard.faceup == false && widget.alwaysFaceUp == false)
      return Container();
    if (topCard.hasImage) {
      return Image.network(
        topCard.imageUrl!,
        errorBuilder: (context, _, __) {
          return AppText(label: 'Failed to load image');
        },
      );
    }
    return Center(
      child: AppText(label: '?'),
    );
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    GameCardModel? topCard = boardProvider.getTopCard(
      widget.rowPosition,
      widget.columnPosition,
    );
    GameCardModel? secondCard = boardProvider.getSecondCard(
      widget.rowPosition,
      widget.columnPosition,
    );
    int cardGroupCount = boardProvider
        .getCardGroup(widget.rowPosition, widget.columnPosition)
        .cards
        .length;
    bool topCardHightlighted =
        boardProvider.getTopCard(widget.rowPosition, widget.columnPosition) ==
                boardProvider.highlightedCard &&
            boardProvider.highlightedCard != null;

    return Material(
      child: GestureDetector(
        onDoubleTap: () {
          if (topCard == null || widget.alwaysFaceUp) return;
          setState(() {
            topCard.faceup = !topCard.faceup;
          });
        },
        child: Draggable(
          data: topCard,
          childWhenDragging: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: getCardColor(secondCard),
            ),
            child: getCardImage(secondCard),
          ),
          maxSimultaneousDrags: topCard != null ? 1 : 0,
          //card that is dragged
          feedback: Material(
            child: Container(
              width: widget.cardSize.width * 1.2,
              height: widget.cardSize.height * 1.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                color: getCardColor(topCard),
              ),
              child: getCardImage(topCard),
            ),
          ),
          onDragStarted: () {
            boardProvider.highlightedCard = null;
            return;
          },
          onDragEnd: (DraggableDetails details) {
            if (details.wasAccepted) {
              widget.onDraggedFrom(
                row: widget.rowPosition,
                column: widget.columnPosition,
              );
            }
            return;
          },
          child: GestureDetector(
            onTap: () {
              if (cardGroupCount == 0) {
                boardProvider.clearHighlight();
                return;
              }
              boardProvider.highlightCard(
                widget.rowPosition,
                widget.columnPosition,
              );
              return;
            },
            //stationary card
            child: DragTarget(
              builder: (context, _, __) => Container(
                width: widget.cardSize.width.ceilToDouble(),
                height: widget.cardSize.height.ceilToDouble(),
                decoration: BoxDecoration(
                  color: getCardColor(topCard),
                  border: Border.all(
                    color: topCardHightlighted
                        ? AppColors.hightlight
                        : AppColors.emptyPosition,
                  ),
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: getCardImage(topCard),
              ),
              onWillAccept: (object) {
                if (object is GameCardModel) return true;
                return false;
              },
              onAccept: (object) {
                widget.onDraggedTo(
                  row: widget.rowPosition,
                  column: widget.columnPosition,
                  cardModel: object as GameCardModel,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
