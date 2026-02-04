// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlogModel _$BlogModelFromJson(Map<String, dynamic> json) => BlogModel(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  category: json['category'] as String,
  owner: User.fromJson(json['owner'] as Map<String, dynamic>?),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  likes: (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
  comments: (json['comments'] as List<dynamic>?)?.map((e) {
    if (e is Map<String, dynamic>) {
      return Comment.fromJson(e);
    } else {
      // Handle string IDs
      return Comment(
        id: e.toString(),
        content: '',
        author: User(id: '', username: 'Unknown'),
        createdAt: DateTime.now(),
      );
    }
  }).toList(),
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  thumbnailUrl: json['thumbnailUrl'] as String?,
);

Map<String, dynamic> _$BlogModelToJson(BlogModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'category': instance.category,
  'owner': instance.owner.toJson(),
  'thumbnailUrl': instance.thumbnailUrl,
  'likes': instance.likes,
  'comments': instance.comments?.map((c) => c.toJson()).toList(),
  'tags': instance.tags,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
