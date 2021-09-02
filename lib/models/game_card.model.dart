class GameCardModel {
  String name;
  String descriptionAccent;
  String description;
  String? imageUrl;
  String? customBackUrl;
  int topLeft;
  int topRight;
  int bottomLeft;
  int bottomRight;
  bool faceup;
  GameCardModel({
    this.name = 'Unknown',
    this.description = '[desc]',
    this.descriptionAccent = '[card info]',
    this.imageUrl,
    this.customBackUrl,
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
    this.faceup = true,
  });
}
