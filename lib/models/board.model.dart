import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'game_card.model.dart';

part 'board.model.g.dart';

@JsonSerializable()
class BoardModel {
  int rows;
  int columns;
  //outter list is rows
  //inner list is columns
  List<List<GameCardGroupModel>> positions = [];
  List<GameCardGroupModel> player1Hand = [];
  List<GameCardGroupModel> player2Hand = [];

  BoardModel({required this.rows, required this.columns}) {
    rows = rows;
    columns = columns;
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
      positions.add(row);
    }
    return;
  }

  GameCardGroupModel condenseCards(int row, int column) {
    List<GameCardModel> allCards = [];
    for (var row in positions) {
      for (var group in row) {
        allCards.addAll(group.cards);
      }
    }
    for (var group in player1Hand) {
      allCards.addAll(group.cards);
    }
    for (var group in player2Hand) {
      allCards.addAll(group.cards);
    }
    for (var card in allCards) {
      card.faceup = false;
    }
    return GameCardGroupModel(
      rowPosition: row,
      columnPosition: column,
      cards: allCards,
    );
  }

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);

  Map<String, dynamic> toJson() => _$BoardModelToJson(this);
}
