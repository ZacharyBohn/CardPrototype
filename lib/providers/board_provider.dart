import 'package:flutter/cupertino.dart';
import 'package:game_prototype/models/board.model.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';

class BoardProvider with ChangeNotifier {
  BoardProvider() {
    _board = BoardModel(
      rows: 5,
      columns: 7,
    );
    return;
  }
  late BoardModel _board;
  int get rows => _board.rows;
  int get columns => _board.columns;

  GameCardGroupModel getCardGroup(int row, int column) {
    return _board.positions[row][column];
  }

  void setCardGroup(int row, int column, GameCardGroupModel cardGroup) {
    _board.positions[row][column] = cardGroup;
    notifyListeners();
    return;
  }

  GameCardModel? getTopCard(int row, int column) {
    return _board.positions[row][column].topCard;
  }

  void setTopCard(int row, int column, GameCardModel card) {
    _board.positions[row][column].addCardToTop(card);
    notifyListeners();
    return;
  }

  void removeTopCard(int row, int column) {
    _board.positions[row][column].removeCardFromTop();
    notifyListeners();
    return;
  }
}
