// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paper_without_id_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaperWithoutIdModel _$PaperWithoutIdModelFromJson(Map<String, dynamic> json) =>
    PaperWithoutIdModel(
      name: json['name'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      value: (json['value'] as num).toDouble(),
      grammage: (json['grammage'] as num).toDouble(),
    );

Map<String, dynamic> _$PaperWithoutIdModelToJson(
        PaperWithoutIdModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'value': instance.value,
      'grammage': instance.grammage,
    };
