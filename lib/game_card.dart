import 'package:flutter/material.dart';
import 'enum/app_colors.dart';
import 'models/game_card_model.dart';

class GameCard extends StatefulWidget {
  final GameCardModel card;
  final int indexPosition;
  final Size cardSize;
  final void Function(int) onDraggedFrom;
  const GameCard({
    required this.card,
    required this.indexPosition,
    required this.cardSize,
    required this.onDraggedFrom,
  });

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    //use fractionally sized box to build sub components
    return Material(
      child: Draggable(
        data: widget.card,
        feedback: Material(
          child: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.2,
            color: AppColors.cardNameBackground,
            child: subCard(widget.card.name),
          ),
        ),
        onDragEnd: (DraggableDetails details) {
          if (!details.wasAccepted) return;
          widget.onDraggedFrom(widget.indexPosition);
        },
        child: Container(
          width: widget.cardSize.width.ceilToDouble(),
          height: widget.cardSize.height.ceilToDouble(),
          color: AppColors.cardNameBackground,
          child: Stack(
            children: [
              subCard(widget.card.name),
              cardButtons(widget.cardSize.width / 2),
            ],
          ),
        ),
      ),
    );
  }
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
            color: Colors.black,
            iconSize: 20,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  "First",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                value: 1,
              ),
              PopupMenuItem(
                child: Text(
                  "Second",
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
