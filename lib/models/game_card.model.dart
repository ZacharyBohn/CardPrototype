import 'package:json_annotation/json_annotation.dart';

part 'game_card.model.g.dart';

@JsonSerializable()
class GameCardModel {
  String name;
  String? descriptionAccent;
  String description;
  String? imageUrl;
  String? topLeft;
  String? topRight;
  String? bottomLeft;
  String? bottomRight;
  bool faceup;
  GameCardModel({
    name,
    description,
    descriptionAccent,
    imageUrl,
    topLeft,
    topRight,
    bottomLeft,
    bottomRight,
    faceup,
  })  : this.name = name ?? 'Unknown',
        this.description = description ?? 'Unknown',
        this.faceup = faceup ?? false,
        this.descriptionAccent = descriptionAccent,
        this.imageUrl = imageUrl,
        this.topLeft = topLeft,
        this.topRight = topRight,
        this.bottomLeft = bottomLeft,
        this.bottomRight = bottomRight;

  static GameCardModel? fromString(String string) {
    //assume string is a comma seperates line
    List<String> values = string.split(',');
    values.forEach((element) => element.trim());
    String name = '';
    String descriptionAccent = '';
    String description = '';
    String imageUrl = '';
    String topLeft = '';
    String topRight = '';
    String bottomLeft = '';
    String bottomRight = '';
    if (values.length > 0) {
      name = values[0];
    }
    if (values.length > 1) {
      descriptionAccent = values[1];
    }
    if (values.length > 2) {
      description = values[2];
    }
    if (values.length > 3) {
      imageUrl = values[3];
    }
    if (values.length > 4) {
      topLeft = values[4];
    }
    if (values.length > 5) {
      topRight = values[5];
    }
    if (values.length > 6) {
      bottomLeft = values[6];
    }
    if (values.length > 7) {
      bottomRight = values[7];
    }
    if (name.isEmpty || description.isEmpty) return null;
    return GameCardModel(
      name: name,
      descriptionAccent: descriptionAccent,
      description: description,
      imageUrl: imageUrl,
      topLeft: topLeft,
      topRight: topRight,
      bottomLeft: bottomLeft,
      bottomRight: bottomRight,
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
      topLeft: this.topLeft,
      topRight: this.topRight,
      bottomLeft: this.bottomLeft,
      bottomRight: this.bottomRight,
      faceup: this.faceup,
    );
  }

  factory GameCardModel.fromJson(Map<String, dynamic> json) =>
      _$GameCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameCardModelToJson(this);
}
