import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:game_prototype/models/board.model.dart';
import 'package:game_prototype/models/game_card.model.dart';
import 'package:game_prototype/models/game_card_group.model.dart';
import 'package:game_prototype/utils/helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardProvider with ChangeNotifier {
  BoardProvider() {
    _board = BoardModel(
      rows: 5,
      columns: 7,
    );
    //setup hands
    for (var x in Iterable.generate(7)) {
      _board.player1Hand
          .add(GameCardGroupModel(rowPosition: 5, columnPosition: x));
      _board.player2Hand
          .add(GameCardGroupModel(rowPosition: -1, columnPosition: x));
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

  bool highlightedCardChanged = false;

  GameCardGroupModel? movingCardGroup;

  Timer? saveToDiskTimer;
  late SharedPreferences prefs;
  bool readingFromDisk = false;

  Future<void> readFromDisk() async {
    readingFromDisk = true;
    try {
      prefs = await SharedPreferences.getInstance();
      String? data = prefs.getString('ccg');
      if (data != null) {
        Map? map = jsonDecode(data);
        if (map != null && map is Map<String, dynamic>) {
          _board = BoardModel.fromJson(map);
        }
      }
    } catch (e) {
      debugPrint('Failed to open Hive box: $e');
    }
    readingFromDisk = false;
    notifyListeners();
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
      Map<String, dynamic> data = _board.toJson();
      await prefs.setString('ccg', jsonEncode(data));
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

  GameCardGroupModel getCardGroup(int row, int column) {
    if (row == rows) {
      return _board.player1Hand[column];
    }
    if (row == -1) {
      return _board.player2Hand[column];
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
      _board.player1Hand[column] =
          GameCardGroupModel(rowPosition: row, columnPosition: column);
      return;
    }
    if (row == -1) {
      _board.player2Hand[column] =
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
      return _board.player1Hand[column].topCard;
    }
    if (row == -1) {
      return _board.player2Hand[column].topCard;
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

  void updateAllCardsWithName(String name, GameCardModel updatedCard) {
    for (var row in _board.positions) {
      for (var group in row) {
        for (var cardIndex in Iterable.generate(group.cards.length)) {
          if (group.cards[cardIndex].name == name) {
            group.cards[cardIndex] = updatedCard.copy();
          }
        }
      }
    }
    return;
  }

  void addCardToTop(int row, int column, GameCardModel card) {
    if (row == rows) {
      card.faceup = true;
      _board.player1Hand[column].addCardToTop(card);
      return;
    }
    if (row == -1) {
      card.faceup = true;
      _board.player2Hand[column].addCardToTop(card);
      return;
    }
    _board.positions[row][column].addCardToTop(card);
    notifyListeners();
    saveToDisk();
    return;
  }

  void removeTopCard(int row, int column) {
    if (row == rows) {
      _board.player1Hand[column].removeCardFromTop();
      return;
    }
    if (row == -1) {
      _board.player2Hand[column].removeCardFromTop();
      return;
    }
    _board.positions[row][column].removeCardFromTop();
    notifyListeners();
    saveToDisk();
    return;
  }

  void highlightCard(int row, int column) {
    highlightedCardChanged = true;
    if (row == rows) {
      _highlightedCard = _board.player1Hand[column].topCard;
      if (_highlightedCard != null) {
        _highlightedRow = row;
        _highlightedColumn = column;
      }
      notifyListeners();
      return;
    }
    if (row == -1) {
      _highlightedCard = _board.player2Hand[column].topCard;
      if (_highlightedCard != null) {
        _highlightedRow = row;
        _highlightedColumn = column;
      }
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
