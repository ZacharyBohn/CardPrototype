import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:game_prototype/models/board.model.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/utils/helpers.dart';
import 'package:hive/hive.dart';

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
    readFromDisk();
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

  Timer? saveToDiskTimer;
  final box = Hive.box<Map<String, dynamic>>('CCG_Prototype');
  bool readingFromDisk = false;

  Future<void> readFromDisk() async {
    readingFromDisk = true;
    Map<String, dynamic>? data = box.get('data');
    if (data == null) {
      return;
    }
    _board = BoardModel.fromJson(data);
    readingFromDisk = false;
    return;
  }

  dispose() {
    saveToDiskTimer?.cancel();
    super.dispose();
    return;
  }

  Future<void> saveToDisk() async {
    if (readingFromDisk) {
      return;
    }
    saveToDiskTimer?.cancel();
    saveToDiskTimer = Timer(Duration(milliseconds: 400), () async {
      await box.put('data', _board.toJson());
      return;
    });
  }

  bool _movingAllCards = false;
  bool get movingAllCards => _movingAllCards;
  set movingAllCards(value) {
    _movingAllCards = value;
    notifyListeners();
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
    saveToDisk();
    return;
  }

  void removeCardGroup(int row, int column) {
    if (row == rows) {
      player1Hand[column] =
          GameCardGroupModel(rowPosition: row, columnPosition: column);
      return;
    }
    if (row == -1) {
      player2Hand[column] =
          GameCardGroupModel(rowPosition: row, columnPosition: column);
      return;
    }
    _board.positions[row][column] =
        GameCardGroupModel(rowPosition: row, columnPosition: column);
    notifyListeners();
    saveToDisk();
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
      this.addCardToTop(row, column, groupModel.cards[index]);
    }
    return;
  }

  void addCardToTop(int row, int column, GameCardModel card) {
    if (row == rows) {
      card.faceup = true;
      player1Hand[column].addCardToTop(card);
      return;
    }
    if (row == -1) {
      card.faceup = true;
      player2Hand[column].addCardToTop(card);
      return;
    }
    _board.positions[row][column].addCardToTop(card);
    notifyListeners();
    saveToDisk();
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
    saveToDisk();
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
