import 'package:flutter/material.dart';
import '../enum/app_colors.dart';
import '../models/game_card.model.dart';

class GameCard extends StatefulWidget {
  final GameCardModel card;
  final Size cardSize;
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
  const GameCard({
    required this.card,
    required this.cardSize,
    required this.onDraggedFrom,
    required this.onDraggedTo,
    this.onPopupItemSelected,
  });

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  int? cursorStartX;
  int? cursorStartY;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Draggable(
        data: widget.card,
        childWhenDragging: Container(
          // width: widget.cardSize.width * 1.2,
          // height: widget.cardSize.height * 1.2,
          color: AppColors.emptyPosition,
        ),
        feedback: Positioned(
          child: Material(
            child: Container(
              width: widget.cardSize.width * 1.1,
              height: widget.cardSize.height * 1.1,
              color: widget.card.faceup
                  ? AppColors.cardForeground
                  : AppColors.cardBack,
            ),
          ),
        ),
        onDragStarted: () {},
        onDragEnd: (DraggableDetails details) {
          if (!details.wasAccepted) return;
          widget.onDraggedFrom(
            row: widget.card.rowPosition,
            column: widget.card.columPosition,
          );
        },
        child: DragTarget(
          builder: (context, _, __) => Container(
            // width: widget.cardSize.width.ceilToDouble(),
            // height: widget.cardSize.height.ceilToDouble(),
            color: widget.card.faceup
                ? AppColors.cardForeground
                : AppColors.cardBack,
          ),
          onWillAccept: (object) {
            if (object is GameCardModel) return true;
            return false;
          },
          onAccept: (object) {
            widget.onDraggedTo(
              row: widget.card.rowPosition,
              column: widget.card.columPosition,
              cardModel: object as GameCardModel,
            );
          },
        ),
      ),
    );
  }
}
