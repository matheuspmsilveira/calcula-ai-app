// ignore_for_file: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'paper_model.g.dart';

@JsonSerializable()
class PaperModel {
  final String id;
  final String name;
  final int width;
  final int height;
  final double value;
  final double grammage;

  PaperModel({
    required this.id,
    required this.name,
    required this.width,
    required this.height,
    required this.value,
    required this.grammage,
  });

  factory PaperModel.fromJson(Map<String, dynamic> json) =>
      _$PaperModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaperModelToJson(this);
}
