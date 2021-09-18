class GameCardModel {
  late String id;
  late String name;
  late String descriptionAccent;
  late String description;
  late String? imageUrl;
  late String? customBackUrl;
  late String? topLeft;
  late String? topRight;
  late String? bottomLeft;
  late String? bottomRight;
  late bool faceup;
  GameCardModel({
    required this.id,
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

  GameCardModel.fromString(String string) {
    //assume string is a comma seperates line
    List<String> values = string.split(',');
    values.forEach((element) => element.trim());
    if (values.length != 10) {
      String error = 'Failed to Load';
      this.id = error;
      this.name = error;
      this.descriptionAccent = error;
      this.description = error;
      this.imageUrl = error;
      this.customBackUrl = error;
      this.topLeft = error;
      this.topRight = error;
      this.bottomLeft = error;
      this.bottomRight = error;
      this.faceup = true;
      return;
    }
    this.id = values[0];
    this.name = values[1];
    this.descriptionAccent = values[2];
    this.description = values[3];
    this.imageUrl = values[4];
    this.customBackUrl = values[5];
    this.topLeft = values[6];
    this.topRight = values[7];
    this.bottomLeft = values[8];
    this.bottomRight = values[9];
  }

  bool get hasImage => imageUrl != null;

  GameCardModel copy() {
    return GameCardModel(
      id: this.id,
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
