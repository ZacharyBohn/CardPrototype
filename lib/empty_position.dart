import 'package:flutter/material.dart';

import 'models/game_card.model.dart';

class EmptyPosition extends StatelessWidget {
  final int indexPosition;
  final Color color;
  final void Function(int, GameCardModel) onDraggedTo;

  const EmptyPosition({
    required this.indexPosition,
    required this.color,
    required this.onDraggedTo,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      builder: (context, data, __) {
        return GestureDetector(
          child: Container(
            color: color,
          ),
        );
      },
      onWillAccept: (object) {
        if (object is GameCardModel) return true;
        return false;
      },
      onAccept: (object) {
        onDraggedTo(indexPosition, object as GameCardModel);
      },
    );
  }
}
