import 'package:flutter/cupertino.dart';
import 'package:game_prototype/models/board.model.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/utils/helpers.dart';

class BoardProvider with ChangeNotifier {
  BoardProvider() {
    _board = BoardModel(
      rows: 5,
      columns: 7,
    );
    //setup hands
    for (var x in Iterable.generate(7)) {
      player1Hand.add(GameCardGroupModel(rowPosition: 5, columnPosition: x));
      player2Hand.add(GameCardGroupModel(rowPosition: -1, columnPosition: x));
    }
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

  List<GameCardGroupModel> player1Hand = [];
  List<GameCardGroupModel> player2Hand = [];

  GameCardGroupModel getCardGroup(int row, int column) {
    if (row == rows) {
      return player1Hand[column];
    }
    if (row == -1) {
      return player2Hand[column];
    }
    return _board.positions[row][column];
  }

  void setCardGroup(int row, int column, GameCardGroupModel cardGroup) {
    _board.positions[row][column] = cardGroup;
    notifyListeners();
    return;
  }

  void removeCardGroup(int row, int column) {
    this.setCardGroup(
        row,
        column,
        GameCardGroupModel(
          rowPosition: row,
          columnPosition: column,
        ));
    return;
  }

  GameCardModel? getTopCard(int row, int column) {
    if (row == rows) {
      return player1Hand[column].topCard;
    }
    if (row == -1) {
      return player2Hand[column].topCard;
    }
    return _board.positions[row][column].topCard;
  }

  GameCardModel? getSecondCard(int row, int column) {
    if (row == -1 || row == rows) return null;
    return _board.positions[row][column].secondCard;
  }

  void addGroupToTop(int row, int column, GameCardGroupModel groupModel) {
    //loop through the group backwards, adding each card to the top
    int len = groupModel.cards.length;
    for (int x in range(len)) {
      int index = len - x - 1;
      this.setTopCard(row, column, groupModel.cards[index]);
    }
    return;
  }

  void setTopCard(int row, int column, GameCardModel card) {
    if (row == rows) {
      player1Hand[column].addCardToTop(card);
      return;
    }
    if (row == -1) {
      player2Hand[column].addCardToTop(card);
      return;
    }
    _board.positions[row][column].addCardToTop(card);
    notifyListeners();
    return;
  }

  void removeTopCard(int row, int column) {
    if (row == rows) {
      player1Hand[column].removeCardFromTop();
      return;
    }
    if (row == -1) {
      player2Hand[column].removeCardFromTop();
      return;
    }
    _board.positions[row][column].removeCardFromTop();
    notifyListeners();
    return;
  }

  void highlightCard(int row, int column) {
    if (row == rows) {
      _highlightedCard = player1Hand[column].topCard;
      notifyListeners();
      return;
    }
    if (row == -1) {
      _highlightedCard = player2Hand[column].topCard;
      notifyListeners();
      return;
    }
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
