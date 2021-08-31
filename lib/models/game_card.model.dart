class GameCardModel {
  String name;
  String description;
  String? imageUrl;
  String? customBackUrl;
  int? value1;
  int? value2;
  int? value3;
  int? value4;
  bool faceup;
  GameCardModel({
    this.name = 'Unknown',
    this.description = '[desc]',
    this.imageUrl,
    this.customBackUrl,
    this.value1,
    this.value2,
    this.value3,
    this.value4,
    this.faceup = true,
  });
}
