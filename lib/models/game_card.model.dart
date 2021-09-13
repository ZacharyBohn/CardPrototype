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

  bool get hasImage => imageUrl != null;

  GameCardModel copy() {
    return GameCardModel(
      name: this.name,
      descriptionAccent: this.descriptionAccent,
      description: this.description,
      imageUrl: this.imageUrl,
      customBackUrl: this.customBackUrl,
      topLeft: this.topLeft,
      topRight: this.topRight,
      bottomLeft: this.bottomLeft,
      bottomRight: this.bottomRight,
      faceup: this.faceup,
    );
  }
}
