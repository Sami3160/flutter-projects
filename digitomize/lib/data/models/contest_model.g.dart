// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestModel _$ContestModelFromJson(Map<String, dynamic> json) => ContestModel(
  host: json['host'] as String,
  name: json['name'] as String,
  duration: json['duration'] as int,
  vanity: json['vanity'] as String,
  startTimeUnix: json['startTimeUnix'] as int,
  platform: json['platform'] as String?,
);

Map<String, dynamic> _$ContestModelToJson(ContestModel instance) =>
    <String, dynamic>{
      'host': instance.host,
      'name': instance.name,
      'duration': instance.duration,
      'vanity': instance.vanity,
      'startTimeUnix': instance.startTimeUnix,
      'platform': instance.platform,
    };
