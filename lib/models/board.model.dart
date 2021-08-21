import 'package:game_prototype/models/game_card_group.model.dart';

class BoardModel {
  int rows;
  int columns;
  //outter list is rows
  //inner list is columsn
  List<List<GameCardGroupModel>> _positions = [];

  BoardModel({required this.rows, required this.columns}) {
    for (int _ in Iterable.generate(rows)) {
      List<GameCardGroupModel> row = [];
      //add 1 game card group model for each column in the row
      for (int __ in Iterable.generate(columns)) {
        row.add(GameCardGroupModel());
      }
      _positions.add(row);
    }
    return;
  }
}
