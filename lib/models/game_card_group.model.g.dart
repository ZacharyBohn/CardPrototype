// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_card_group.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameCardGroupModel _$GameCardGroupModelFromJson(Map<String, dynamic> json) =>
    GameCardGroupModel(
      rowPosition: json['rowPosition'] as int,
      columnPosition: json['columnPosition'] as int,
      cards: (json['cards'] as List<dynamic>?)
          ?.map((e) => GameCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GameCardGroupModelToJson(GameCardGroupModel instance) =>
    <String, dynamic>{
      'rowPosition': instance.rowPosition,
      'columnPosition': instance.columnPosition,
      'cards': instance.cards,
    };
