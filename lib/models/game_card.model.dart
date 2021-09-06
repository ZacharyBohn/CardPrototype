class GameCardModel {
  String name;
  String descriptionAccent;
  String description;
  String? imageUrl;
  String? customBackUrl;
  String? topLeft;
  String? topRight;
  String? bottomLeft;
  String? bottomRight;
  bool faceup;
  GameCardModel({
    this.name = 'Unknown',
    this.description = '[desc]',
    this.descriptionAccent = '[card info]',
    this.imageUrl,
    this.customBackUrl,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.faceup = true,
  });
}
