// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCardModel _$GameCardModelFromJson(Map<String, dynamic> json) =>
    GameCardModel(
      name: json['name'],
      description: json['description'],
      descriptionAccent: json['descriptionAccent'],
      imageUrl: json['imageUrl'],
      topLeft: json['topLeft'],
      topRight: json['topRight'],
      bottomLeft: json['bottomLeft'],
      bottomRight: json['bottomRight'],
      faceup: json['faceup'],
    );

Map<String, dynamic> _$GameCardModelToJson(GameCardModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'descriptionAccent': instance.descriptionAccent,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'topLeft': instance.topLeft,
      'topRight': instance.topRight,
      'bottomLeft': instance.bottomLeft,
      'bottomRight': instance.bottomRight,
      'faceup': instance.faceup,
    };
