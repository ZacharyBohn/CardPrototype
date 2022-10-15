import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_prototype/enum/fonts.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
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
  final bool disableMovingAllCards;
  final bool canDragTo;
  final void Function({
    required int row,
    required int column,
    required bool moveAllCards,
  }) onDraggedFrom;
  final void Function({
    required int row,
    required int column,
  }) onDraggedTo;
  final void Function(int)? onPopupItemSelected;
  const GameCardGroupWidget({
    required this.rowPosition,
    required this.columnPosition,
    required this.cardSize,
    required this.onDraggedFrom,
    required this.onDraggedTo,
    this.onPopupItemSelected,
    this.disableMovingAllCards = false,
    this.canDragTo = true,
    this.alwaysFaceUp = false,
    this.onlyOneCard = false,
  });

  @override
  _GameCardGroupWidgetState createState() => _GameCardGroupWidgetState();
}

class _GameCardGroupWidgetState extends State<GameCardGroupWidget> {
  double borderRadius = 0.0;
  int? dragStartedTimeStamp;
  Offset? longPressStartedAtPos;
  Timer? longDragTimer;
  DragUpdateDetails? dragDetails;

  StreamController draggableStream = StreamController<bool>();

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

  Widget? getCardImage(
    GameCardModel? topCard, {
    bool subtractOneFromCardCount = false,
    bool hideNumber = false,
  }) {
    if (topCard == null) return Container();

    GameCardGroupModel groupModel = context
        .read<BoardProvider>()
        .getCardGroup(widget.rowPosition, widget.columnPosition);
    int cards = groupModel.cards.length;
    if (subtractOneFromCardCount) {
      cards--;
    }
    if (hideNumber) {
      cards = 0;
    }
    return Stack(
      children: [
        getInnerCardImage(
          topCard,
          subtractOneFromCardCount: subtractOneFromCardCount,
        ),
        Align(
          alignment: Alignment.topRight,
          child: AppText(
            label: cards == 0 || cards == 1 ? '' : '$cards',
            fontSize: FontSizes.small,
          ),
        ),
      ],
    );
  }

  Widget getInnerCardImage(
    GameCardModel? topCard, {
    bool subtractOneFromCardCount = false,
  }) {
    if (topCard == null) return Container();
    if (topCard.faceup == false && widget.alwaysFaceUp == false)
      return Container();
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (topCard.hasImage)
          Expanded(
            child: Image.network(
              topCard.imageUrl!,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (context, _, __) {
                return AppText(label: '[Image Error]');
              },
            ),
          ),
        Center(
          child: AppText(
            label: topCard.name.isNotEmpty ? topCard.name : '?',
            fontSize: FontSizes.small,
          ),
        ),
      ],
    );
  }

  int getEpochMs() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  bool didCursorLeaveCard() {
    double deltaX =
        (dragDetails!.globalPosition.dx - longPressStartedAtPos!.dx);
    double deltaY =
        (dragDetails!.globalPosition.dy - longPressStartedAtPos!.dy);
    deltaX = deltaX.abs();
    deltaY = deltaY.abs();

    bool withinXBound = deltaX < (widget.cardSize.width * 0.8);
    bool withinYBound = deltaY < (widget.cardSize.height * 0.8);

    if (withinXBound && withinYBound) {
      return false;
    }
    return true;
  }

  void checkLongDrag() {
    if (widget.disableMovingAllCards) {
      return;
    }
    if (dragDetails == null) {
      return;
    }
    if (longPressStartedAtPos == null || didCursorLeaveCard()) {
      return;
    }
    setState(() {
      Provider.of<BoardProvider>(context, listen: false).movingAllCards = true;
      draggableStream.add(true);
    });
    return;
  }

  @override
  Widget build(BuildContext context) {
    BoardProvider boardProvider = Provider.of<BoardProvider>(context);
    GameCardGroupModel groupModel =
        boardProvider.getCardGroup(widget.rowPosition, widget.columnPosition);
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
          bool newFace = !topCard.faceup;
          for (var x in groupModel.cards) {
            x.faceup = newFace;
          }
          setState(() {
            groupModel = groupModel;
          });
          boardProvider.highlightedCard = boardProvider.highlightedCard;
          boardProvider.saveToDisk();
        },
        child: Draggable(
          data: groupModel,
          childWhenDragging: Container(
            width: widget.cardSize.width * 1.2,
            height: widget.cardSize.height * 1.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: getCardColor(secondCard),
            ),
            child: boardProvider.movingAllCards
                ? null
                : getCardImage(
                    secondCard,
                    subtractOneFromCardCount: true,
                  ),
          ),
          maxSimultaneousDrags: 1,
          //card that is dragged
          feedback: Material(
            child: StreamBuilder(
              initialData: false,
              stream: draggableStream.stream,
              builder: (context, _) {
                return Container(
                  width: widget.cardSize.width * 1.2,
                  height: widget.cardSize.height * 1.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    color: getCardColor(topCard),
                    border: boardProvider.movingAllCards
                        ? Border.all(
                            width: 2,
                            color: AppColors.grabbingAllCardsHighlight,
                          )
                        : null,
                  ),
                  child: getCardImage(topCard, hideNumber: true),
                );
              },
            ),
          ),
          onDragStarted: () {
            boardProvider.highlightedCard = null;
            boardProvider.movingAllCards = false;
            dragStartedTimeStamp = getEpochMs();
            longDragTimer = Timer(
              Duration(milliseconds: 650),
              checkLongDrag,
            );
            boardProvider.movingCardGroup = boardProvider.getCardGroup(
              widget.rowPosition,
              widget.columnPosition,
            );
            return;
          },
          onDragUpdate: (details) {
            dragDetails = details;
            if (longPressStartedAtPos == null) {
              longPressStartedAtPos = details.globalPosition;
            }
            return;
          },
          onDragEnd: (DraggableDetails details) {
            if (details.wasAccepted) {
              widget.onDraggedFrom(
                row: widget.rowPosition,
                column: widget.columnPosition,
                moveAllCards: boardProvider.movingAllCards,
              );
            }
            setState(() {
              draggableStream = StreamController<bool>();
              longPressStartedAtPos = null;
              dragStartedTimeStamp = null;
            });
            return;
          },
          child: GestureDetector(
            onTap: () {
              if (cardGroupCount == 0) {
                boardProvider.highlightedCardChanged = true;
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
                if (widget.canDragTo == false) return false;
                if (object is GameCardGroupModel) return true;
                return false;
              },
              onAccept: (object) {
                widget.onDraggedTo(
                  row: widget.rowPosition,
                  column: widget.columnPosition,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
