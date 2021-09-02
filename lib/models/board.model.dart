import 'package:game_prototype/models/game_card_group.model.dart';

class BoardModel {
  late int _rows;
  int get rows => _rows;
  late int _columns;
  int get columns => _columns;
  //outter list is rows
  //inner list is columns
  List<List<GameCardGroupModel>> _positions = [];

  List<List<GameCardGroupModel>> get positions => _positions;

  BoardModel({required int rows, required int columns}) {
    _rows = rows;
    _columns = columns;
    for (int rowPosition in Iterable.generate(rows)) {
      List<GameCardGroupModel> row = [];
      for (int columnPosition in Iterable.generate(columns)) {
        row.add(
          GameCardGroupModel(
            rowPosition: rowPosition,
            columnPosition: columnPosition,
            cards: [],
          ),
        );
      }
      _positions.add(row);
    }
    return;
  }
}
