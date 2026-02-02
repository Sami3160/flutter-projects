import 'package:digitomize/domain/entities/contest.dart';
import 'package:json_annotation/json_annotation.dart';
part 'contest_model.g.dart';

@JsonSerializable()
class ContestModel extends Contest {
  ContestModel({
    this.host,
    this.name,
    this.duration,
    this.platform,
    this.vanity,
    this.startTimeUnix,
  }) : super(
         host: host,
         name: name,
         duration: duration,
         platform: platform,
         vanity: vanity,
         startTimeUnix: startTimeUnix,
       );

  @override
  String? host;
  @override
  String? name;
  @override
  int? duration;
  @override
  String? vanity;
  @override
  int? startTimeUnix;
  @override
  String? platform;

  factory ContestModel.fromJson(Map<String, dynamic> json) =>
      _$ContestModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$ContestModelToJson(this);
}
