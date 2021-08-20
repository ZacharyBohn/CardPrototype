import 'package:flutter/material.dart';
import 'enum/app_colors.dart';
import 'models/game_card.model.dart';

class GameCard extends StatefulWidget {
  final GameCardModel card;
  final int indexPosition;
  final Size cardSize;
  final void Function(int) onDraggedFrom;
  final void Function(int, GameCardModel) onDraggedTo;
  final void Function(int)? onPopupItemSelected;
  const GameCard({
    required this.card,
    required this.indexPosition,
    required this.cardSize,
    required this.onDraggedFrom,
    required this.onDraggedTo,
    this.onPopupItemSelected,
  });

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Draggable(
        data: widget.card,
        childWhenDragging: Container(
          color: AppColors.emptyPositionHighlighted,
        ),
        feedback: Material(
          child: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.2,
            color: AppColors.cardNameBackground,
            child: widget.card.faceup
                ? subCard(widget.card.name)
                : cardBack(widget.cardSize),
          ),
        ),
        onDragEnd: (DraggableDetails details) {
          if (!details.wasAccepted) return;
          widget.onDraggedFrom(widget.indexPosition);
        },
        child: DragTarget(
          builder: (context, _, __) => Container(
            width: widget.cardSize.width.ceilToDouble(),
            height: widget.cardSize.height.ceilToDouble(),
            color: AppColors.cardNameBackground,
            child: Stack(
              children: [
                widget.card.faceup
                    ? subCard(widget.card.name)
                    : cardBack(widget.cardSize),
                cardButtons(widget.cardSize.width / 2),
              ],
            ),
          ),
          onWillAccept: (object) {
            if (object is GameCardModel) return true;
            return false;
          },
          onAccept: (object) {
            widget.onDraggedTo(widget.indexPosition, object as GameCardModel);
          },
        ),
      ),
    );
  }

  Widget cardBack(Size cardSize) {
    return Container(
      color: AppColors.cardBack,
      width: cardSize.width,
      height: cardSize.height,
    );
  }

  Widget subCard(String cardName) {
    return Column(
      children: [
        //card image
        Flexible(
          flex: 5,
          child: Container(color: AppColors.cardBackground),
        ),
        //card name
        Flexible(
          flex: 4,
          child: Container(
            color: AppColors.cardNameBackground,
            child: Center(
              child: Text(
                cardName,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.fontColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cardButtons(double iconWidth) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            PopupMenuButton(
              onSelected: (int value) {
                switch (value) {
                  case 1:
                    setState(() {
                      widget.card.faceup = !widget.card.faceup;
                    });
                }
              },
              color: Colors.black,
              iconSize: 20,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    "Flip",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  value: 1,
                ),
                PopupMenuItem(
                  child: Text(
                    "?",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  value: 2,
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
