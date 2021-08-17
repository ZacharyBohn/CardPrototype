import 'package:flutter/material.dart';
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
        feedback: Container(
          width: widget.cardSize.width * 1.2,
          height: widget.cardSize.height * 1.2,
          color: Colors.black45,
          child: subCard(widget.card.name),
        ),
        onDragEnd: (DraggableDetails details) {
          widget.onDraggedFrom(widget.indexPosition);
        },
        child: Container(
          width: widget.cardSize.width.ceilToDouble(),
          height: widget.cardSize.height.ceilToDouble(),
          color: Colors.black45,
          child: subCard(widget.card.name),
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
        flex: 2,
        child: Container(color: Colors.black45),
      ),
      //card name
      Flexible(
        flex: 1,
        child: Container(
          color: Colors.black87,
          child: Center(
            child: Text(
              cardName,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
