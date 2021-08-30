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
  double? mouseX;
  double? mouseY;
  double? offsetX;
  double? offsetY;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (PointerEvent details) {
        mouseX = details.position.dx;
        mouseY = details.position.dy;
        // setState(() {
        //   mouseX = details.position.dx;
        //   mouseY = details.position.dy;
        // });
      },
      child: Material(
        child: Draggable(
          data: widget.card,
          childWhenDragging: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.1,
            color: AppColors.emptyPosition,
          ),
          feedback: Transform.translate(
            //compensate for board x rotation
            offset: Offset(offsetX ?? 0, offsetY ?? 0),
            child: Material(
              child: Container(
                width: widget.cardSize.width * 1.2,
                height: widget.cardSize.height * 1.1,
                color: widget.card.faceup
                    ? AppColors.cardForeground
                    : AppColors.cardBack,
              ),
            ),
          ),
          onDragUpdate: (details) {
            //already calculated
            // if (offsetX != null) return;
            // Offset globalPosition = details.globalPosition;
            // setState(() {
            //   offsetX = mouseX! - globalPosition.dx;
            //   offsetY = mouseY! - globalPosition.dy;
            // });
          },
          onDragEnd: (DraggableDetails details) {
            if (details.wasAccepted) {
              widget.onDraggedFrom(
                row: widget.card.rowPosition,
                column: widget.card.columPosition,
              );
            }
            offsetX = null;
            offsetY = null;
            return;
          },
          child: DragTarget(
            builder: (context, _, __) => Container(
              width: widget.cardSize.width.ceilToDouble(),
              height: widget.cardSize.height.ceilToDouble(),
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
      ),
    );
  }
}
