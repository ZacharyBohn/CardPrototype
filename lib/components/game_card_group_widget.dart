import 'package:flutter/material.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/providers/board_provider.dart';
import 'package:provider/provider.dart';
import '../enum/app_colors.dart';
import '../models/game_card.model.dart';

class GameCardGroupWidget extends StatefulWidget {
  final int rowPosition;
  final int columnPosition;
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
  const GameCardGroupWidget({
    required this.rowPosition,
    required this.columnPosition,
    required this.cardSize,
    required this.onDraggedFrom,
    required this.onDraggedTo,
    this.onPopupItemSelected,
  });

  @override
  _GameCardGroupWidgetState createState() => _GameCardGroupWidgetState();
}

class _GameCardGroupWidgetState extends State<GameCardGroupWidget> {
  double? mouseX;
  double? mouseY;
  double? offsetX;
  double? offsetY;
  // late GameCardGroupModel cardGroup;

  @override
  initState() {
    super.initState();
    return;
  }

  Color getCardColor(GameCardModel? topCard) {
    if (topCard == null) {
      return AppColors.emptyPosition;
    }
    if (topCard.faceup) {
      return AppColors.cardForeground;
    }
    if (topCard.faceup) {
      return AppColors.cardBack;
    }
    throw Exception('No color?');
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    GameCardModel? topCard = boardProvider.getTopCard(
      widget.rowPosition,
      widget.columnPosition,
    );
    int cardGroupCount = boardProvider
        .getCardGroup(widget.rowPosition, widget.columnPosition)
        .cards
        .length;
    return MouseRegion(
      onHover: (PointerEvent details) {
        mouseX = details.position.dx;
        mouseY = details.position.dy;
      },
      child: Material(
        child: Draggable(
          data: topCard,
          childWhenDragging: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.1,
            color: cardGroupCount > 1
                ? AppColors.cardBack
                : AppColors.emptyPosition,
          ),
          maxSimultaneousDrags: topCard != null ? 1 : 0,
          feedback: Transform.translate(
            //compensate for board x rotation
            offset: Offset(offsetX ?? 0, offsetY ?? 0),
            child: Material(
              child: Container(
                width: widget.cardSize.width * 1.2,
                height: widget.cardSize.height * 1.1,
                color: getCardColor(topCard),
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
                row: widget.rowPosition,
                column: widget.columnPosition,
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
              color: getCardColor(topCard),
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
    );
  }
}
