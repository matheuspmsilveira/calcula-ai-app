// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperModel _$PaperModelFromJson(Map<String, dynamic> json) => PaperModel(
      id: json['id'] as String,
      name: json['name'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      value: (json['value'] as num).toDouble(),
      grammage: (json['grammage'] as num).toDouble(),
    );

Map<String, dynamic> _$PaperModelToJson(PaperModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'value': instance.value,
      'grammage': instance.grammage,
    };
