import 'package:flutter/cupertino.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/models/board.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';

class BoardProvider with ChangeNotifier {
  BoardProvider() {
    _board = BoardModel(
      rows: 5,
      columns: 7,
    );
  }
  late BoardModel _board;
  int get rows => _board.rows;
  int get columns => _board.columns;

  BoardModel get board => _board;
}
