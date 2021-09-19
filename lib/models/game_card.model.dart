class GameCardModel {
  late String id;
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
    required this.id,
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
    if (values.length != 10) {
      return null;
    }
    return GameCardModel(
      id: values[0],
      name: values[1],
      descriptionAccent: values[2],
      description: values[3],
      imageUrl: values[4],
      topLeft: values[5],
      topRight: values[6],
      bottomLeft: values[7],
      bottomRight: values[8],
      customBackUrl: values[9],
    );
  }

  String toCsvString() {
    String data = '';
    data += '$id,';
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
