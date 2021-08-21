class GameCardModel {
  String name;
  bool faceup;
  int rowPosition;
  int columPosition;
  GameCardModel({
    this.name = 'Unknown',
    this.faceup = true,
    required this.rowPosition,
    required this.columPosition,
  });
}
