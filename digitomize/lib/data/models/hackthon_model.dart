import 'package:json_annotation/json_annotation.dart';
import 'package:digitomize/domain/entities/hackthon.dart';
part 'hackthon_model.g.dart';

@JsonSerializable()
class HackthonModel extends Hackthon {
  HackthonModel({
    this.host,
    this.name,
    this.vanity,
    this.url,
    this.duration,
    this.registrationStartTimeUnix,
    this.registrationEndTimeUnix,
    this.hackathonStartTimeUnix,
  }) : super(
         host: host,
         name: name,
         vanity: vanity,
         url: url,
         duration: duration,
         registrationStartTimeUnix: registrationStartTimeUnix,
         registrationEndTimeUnix: registrationEndTimeUnix,
         hackathonStartTimeUnix: hackathonStartTimeUnix,
       );

  @override
  String? host;
  @override
  String? name;
  @override
  String? vanity;
  @override
  String? url;
  @override
  int? duration;
  @override
  int? registrationStartTimeUnix;
  @override
  int? registrationEndTimeUnix;
  @override
  int? hackathonStartTimeUnix;

  factory HackthonModel.fromJson(Map<String, dynamic> json) =>
      _$HackthonModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$HackthonModelToJson(this);
}
