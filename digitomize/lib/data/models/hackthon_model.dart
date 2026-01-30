import 'package:json_annotation/json_annotation.dart';
import 'package:digitomize/domain/entities/hackthon.dart';
part 'hackthon_model.g.dart';



@JsonSerializable()
class HackthonModel extends Hackthon {
  HackthonModel({
    required this.host,
    required this.name,
    required this.vanity,
    required this.url,
    required this.duration,
    required this.registrationStartTimeUnix,
    required this.registrationEndTimeUnix,
    required this.hackthonStartTimeUnix,
  }) : super(
    host: host,
    name: name,
    vanity: vanity,
    url: url,
    duration: duration,
    registrationStartTimeUnix: registrationStartTimeUnix,
    registrationEndTimeUnix: registrationEndTimeUnix,
    hackthonStartTimeUnix: hackthonStartTimeUnix,
  );


  @override
  String host;
  @override
  String name;
  @override
  String vanity;
  @override
  String url;
  @override
  int duration;
  @override
  int registrationStartTimeUnix;
  @override
  int registrationEndTimeUnix;
  @override
  int hackthonStartTimeUnix;

  factory HackthonModel.fromJson(Map<String, dynamic> json) => _$HackthonModelFromJson(json);
  Map<String, dynamic> toJson() => _$HackthonModelToJson(this);
}