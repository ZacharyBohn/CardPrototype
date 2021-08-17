import 'package:flutter/material.dart';

class GameCard extends StatefulWidget {
  final int indexPosition;
  const GameCard({
    required this.indexPosition,
  });

  @override
  _GameCardState createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    //use fractionally sized box to build sub components
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(color: Colors.red),
    );
  }
}
