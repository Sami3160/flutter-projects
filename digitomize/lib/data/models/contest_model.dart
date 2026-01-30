import 'package:digitomize/domain/entities/contest.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contest_model.g.dart';

@JsonSerializable()
class ContestModel extends Contest {
  ContestModel({
    required this.title,
    required this.description,
    this.duration,
    required this.end,
    required this.start,
    this.platform,
  }) : super(
         title: title,
         description: description,
         duration: duration,
         end: end,
         start: start,
         platform: platform,
       );

  @override
  String title;
  @override
  String description;
  @override
  ContestDuration? duration;
  @override
  String end;
  @override
  String start;
  @override
  String? platform;

  factory ContestModel.fromJson(Map<String, dynamic> json) =>
      _$ContestModelFromJson(json);
  Map<String, dynamic> toJson() => _$ContestModelToJson(this);
}
