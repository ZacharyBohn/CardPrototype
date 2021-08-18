import 'package:flutter/material.dart';

import 'empty_position.dart';
import 'enum/app_colors.dart';
import 'game_card.dart';
import 'models/game_card_model.dart';

void main() {
  runApp(Prototype());
  return;
}

class Prototype extends StatefulWidget {
  @override
  _PrototypeState createState() => _PrototypeState();
}

class _PrototypeState extends State<Prototype> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => GameBoard(),
        ),
      ),
    );
  }
}

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final double cardAspectRatio = 1.0 / 1.4;
  final int rows = 5;
  final int columns = 7;

  List<GameCardModel?> cards = [];

  @override
  void initState() {
    for (int _ = 0; _ < rows * columns; _++) {
      cards.add(null);
    }
    cards[0] = GameCardModel();
    super.initState();
  }

  /// Warning: Math ahead
  Size getCardSize(Size size) {
    double outterPadding = 40;
    double innerPadding = rows * size.height * 0.01;
    double remainingSpace = size.height - (outterPadding + innerPadding);
    double cardHeight = remainingSpace / rows;
    double cardWidth = cardHeight / (1 / cardAspectRatio);
    return Size(cardWidth, cardHeight);
  }

  int getXFromIndex(int index) {
    return index % rows;
  }

  int getYFromIndex(int index) {
    return index ~/ columns;
  }

  //x, y, and index are 0-based
  int getIndexFromXY(int x, int y) {
    return x + (y * rows);
  }

  /// Called on each build call, reads from `cards`
  /// to build either a game card or an empty position
  List<Widget> buildWidgets(Size cardSize) {
    List<Widget> widgets = [];
    for (int index = 0; index < rows * columns; index++) {
      if (cards[index] == null) {
        widgets.add(
          EmptyPosition(
            indexPosition: index,
            color: AppColors.emptyPosition,
            onDraggedTo: (int indexPosition, GameCardModel card) {
              setState(() {
                cards[indexPosition] = card;
              });
            },
          ),
        );
      }
      if (cards[index] != null) {
        widgets.add(GameCard(
          card: cards[index]!,
          indexPosition: index,
          cardSize: cardSize,
          onDraggedFrom: (int indexPosition) {
            setState(() {
              cards[indexPosition] = null;
            });
          },
        ));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //get the exact size that cards should be
    Size cardSize = getCardSize(size);
    return Container(
      color: AppColors.background,
      child: Row(
        children: [
          //the card list
          Container(
            width: size.width > size.height ? size.height : size.width,
            height: size.height,
            color: AppColors.background,
            child: GridView.count(
              crossAxisCount: 7,
              padding: EdgeInsets.all(20),
              mainAxisSpacing: size.height * 0.01,
              crossAxisSpacing: size.height * 0.01,
              childAspectRatio: cardAspectRatio,
              children: buildWidgets(cardSize),
            ),
          ),
          //the side panel
          Container(
            width: size.width > size.height ? size.width - size.height : 0,
            height: size.height,
            color: AppColors.sidePanelBackground,
          ),
        ],
      ),
    );
  }
}
