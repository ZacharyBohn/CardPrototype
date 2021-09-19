class GameCardModel {
  late String name;
  late String? descriptionAccent;
  late String description;
  late String? imageUrl;
  late String? topLeft;
  late String? topRight;
  late String? bottomLeft;
  late String? bottomRight;
  late bool faceup;
  late String? customBackUrl;
  GameCardModel({
    this.name = 'Unknown',
    this.description = '[desc]',
    this.descriptionAccent = '[card info]',
    this.imageUrl,
    this.topLeft,
    this.topRight,
    this.bottomLeft,
    this.bottomRight,
    this.faceup = true,
    this.customBackUrl,
  });

  static GameCardModel? fromString(String string) {
    //assume string is a comma seperates line
    List<String> values = string.split(',');
    values.forEach((element) => element.trim());
    if (values.length != 9) {
      return null;
    }
    return GameCardModel(
      name: values[0],
      descriptionAccent: values[1],
      description: values[2],
      imageUrl: values[3],
      topLeft: values[4],
      topRight: values[5],
      bottomLeft: values[6],
      bottomRight: values[7],
      customBackUrl: values[8],
    );
  }

  String toCsvString() {
    String data = '';
    data += '$name,';
    data += '$descriptionAccent,';
    data += '$description,';
    data += '$imageUrl,';
    data += '$topLeft,';
    data += '$topRight,';
    data += '$bottomLeft,';
    data += '$bottomRight,';
    data += '$customBackUrl,';
    data += '\n';
    return data;
  }

  bool get hasImage => imageUrl != null && imageUrl!.isNotEmpty;

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
