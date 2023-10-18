// ignore_for_file: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'paper_without_id_modal.g.dart';

@JsonSerializable()
class PaperWithoutIdModel {
  final String name;
  final int width;
  final int height;
  final double value;
  final double grammage;

  PaperWithoutIdModel({
    required this.name,
    required this.width,
    required this.height,
    required this.value,
    required this.grammage,
  });

  factory PaperWithoutIdModel.fromJson(Map<String, dynamic> json) =>
      _$PaperWithoutIdModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaperWithoutIdModelToJson(this);
}
