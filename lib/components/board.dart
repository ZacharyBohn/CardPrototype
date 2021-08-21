import 'package:flutter/material.dart';
import 'package:game_prototype/enum/app_colors.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.board,
      child: Column(
        children: [],
      ),
    );
  }
}
