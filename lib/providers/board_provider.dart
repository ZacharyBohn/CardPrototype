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
  GameCardModel? _highlightedCard;
  GameCardModel? get highlightedCard => _highlightedCard;
  set highlightedCard(value) {
    _highlightedCard = value;
    notifyListeners();
    return;
  }

  int? _highlightedRow;
  int? get highlightedRow => _highlightedRow;
  int? _highlightedColumn;
  int? get highlightedColumn => _highlightedColumn;

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

  GameCardModel? getSecondCard(int row, int column) {
    return _board.positions[row][column].secondCard;
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

  void highlightCard(int row, int column) {
    _highlightedCard = _board.positions[row][column].topCard;
    if (_highlightedCard != null) {
      _highlightedRow = row;
      _highlightedColumn = column;
    }
    notifyListeners();
    return;
  }

  void clearHighlight() {
    _highlightedCard = null;
    notifyListeners();
    return;
  }
}
