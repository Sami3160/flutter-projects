// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hackthon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HackthonModel _$HackthonModelFromJson(Map<String, dynamic> json) =>
    HackthonModel(
      host: json['host'] as String,
      name: json['name'] as String,
      vanity: json['vanity'] as String,
      url: json['url'] as String,
      duration: (json['duration'] as num).toInt(),
      registrationStartTimeUnix: (json['registrationStartTimeUnix'] as num)
          .toInt(),
      registrationEndTimeUnix: (json['registrationEndTimeUnix'] as num).toInt(),
      hackthonStartTimeUnix: (json['hackthonStartTimeUnix'] as num).toInt(),
    );

Map<String, dynamic> _$HackthonModelToJson(HackthonModel instance) =>
    <String, dynamic>{
      'host': instance.host,
      'name': instance.name,
      'vanity': instance.vanity,
      'url': instance.url,
      'duration': instance.duration,
      'registrationStartTimeUnix': instance.registrationStartTimeUnix,
      'registrationEndTimeUnix': instance.registrationEndTimeUnix,
      'hackthonStartTimeUnix': instance.hackthonStartTimeUnix,
    };
