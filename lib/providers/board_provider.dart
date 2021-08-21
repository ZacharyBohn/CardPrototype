import 'package:flutter/cupertino.dart';
import 'package:game_prototype/components/board.dart';
import 'package:game_prototype/models/board.model.dart';

class BoardProvider with ChangeNotifier {
  BoardModel _board = BoardModel(
    rows: 5,
    columns: 7,
  );
  BoardModel get board => _board;
}
