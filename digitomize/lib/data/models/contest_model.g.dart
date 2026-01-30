// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contest_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContestModel _$ContestModelFromJson(Map<String, dynamic> json) => ContestModel(
  title: json['title'] as String,
  description: json['description'] as String,
  duration: json['duration'] == null
      ? null
      : ContestDuration.fromJson(json['duration'] as Map<String, dynamic>),
  end: json['end'] as String,
  start: json['start'] as String,
  platform: json['platform'] as String?,
);

Map<String, dynamic> _$ContestModelToJson(ContestModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'duration': instance.duration,
      'end': instance.end,
      'start': instance.start,
      'platform': instance.platform,
    };
