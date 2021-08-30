import 'game_card.model.dart';

class GameCardGroupModel {
  GameCardGroupModel({
    required this.rowPosition,
    required this.columnPosition,
  }) {
    return;
  }

  int rowPosition;
  int columnPosition;
  List<GameCardModel> _cards = [];
  List<GameCardModel> get cards => _cards;
  bool get isEmpty {
    return _cards.isEmpty;
  }

  bool get isNotEmpty {
    return _cards.isNotEmpty;
  }

  GameCardModel? get topCard {
    if (_cards.isEmpty) return null;
    return _cards[0];
  }

  void addCardToBottom(GameCardModel card) {
    _cards.add(card);
    return;
  }

  void addCardToTop(GameCardModel card) {
    _cards = [card] + _cards;
    return;
  }

  void removeCardFromTop() {
    _cards = _cards.sublist(1);
    return;
  }

  void shuffle() {
    _cards.shuffle();
    return;
  }
}
