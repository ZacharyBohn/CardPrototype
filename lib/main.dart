import 'package:flutter/material.dart';

import 'empty_position.dart';
import 'game_card.dart';
import 'models/card_model.dart';

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
        body: GameBoard(),
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
  final Color emptyCardColor = Colors.cyan.shade800;

  List<GameCardModel?> cards = [];

  @override
  void initState() {
    for (int _ = 0; _ < rows * columns; _++) {
      cards.add(null);
    }
    super.initState();
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
  List<Widget> buildWidgets() {
    List<Widget> widgets = [];
    for (int index = 0; index < rows * columns; index++) {
      if (cards[index] == null) {
        widgets.add(
          EmptyPosition(
            indexPosition: index,
            color: emptyCardColor,
            onTap: (int indexPosition) {
              setState(() {
                cards[indexPosition] = GameCardModel();
              });
            },
          ),
        );
      }
      if (cards[index] != null) {
        widgets.add(GameCard(indexPosition: index));
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          //the card list
          Container(
            width: size.width > size.height ? size.height : size.width,
            height: size.height,
            color: Color.fromRGBO(20, 20, 20, 1),
            child: GridView.count(
              crossAxisCount: 7,
              padding: EdgeInsets.all(20),
              mainAxisSpacing: size.height * 0.01,
              crossAxisSpacing: size.height * 0.01,
              childAspectRatio: cardAspectRatio,
              children: buildWidgets(),
            ),
          ),
          //the side panel
          Container(
            width: size.width > size.height ? size.width - size.height : 0,
            height: size.height,
            color: Colors.cyan.shade900,
          ),
        ],
      ),
    );
  }
}
