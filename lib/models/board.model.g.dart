// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoardModel _$BoardModelFromJson(Map<String, dynamic> json) => BoardModel(
      rows: json['rows'] as int,
      columns: json['columns'] as int,
    )
      ..positions = (json['positions'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map(
                  (e) => GameCardGroupModel.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList()
      ..player1Hand = (json['player1Hand'] as List<dynamic>)
          .map((e) => GameCardGroupModel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..player2Hand = (json['player2Hand'] as List<dynamic>)
          .map((e) => GameCardGroupModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$BoardModelToJson(BoardModel instance) =>
    <String, dynamic>{
      'rows': instance.rows,
      'columns': instance.columns,
      'positions': instance.positions,
      'player1Hand': instance.player1Hand,
      'player2Hand': instance.player2Hand,
    };
