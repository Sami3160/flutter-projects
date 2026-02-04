import 'package:json_annotation/json_annotation.dart';
import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/entities/comment.dart';
import 'package:digitomize/domain/entities/user.dart';
part 'blog_model.g.dart';

@JsonSerializable()
class BlogModel extends Blog {
  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
    this.likes,
    this.comments,
    this.tags,
    this.thumbnailUrl,
  }) : super(
         id: id,
         title: title,
         content: content,
         category: category,
         owner: owner,
         createdAt: createdAt,
         updatedAt: updatedAt,
         likes: likes,
         comments: comments,
         tags: tags,
         thumbnailUrl: thumbnailUrl,
       );

  @override
  String id;
  @override
  String title;
  @override
  String content;
  @override
  String category;
  @override
  User owner;
  @override
  String? thumbnailUrl;
  @override
  List<String>? likes;
  @override
  List<Comment>? comments;
  @override
  List<String>? tags;
  @override
  DateTime createdAt;
  @override
  DateTime updatedAt;

  factory BlogModel.fromJson(Map<String, dynamic> json) =>
      _$BlogModelFromJson(json);
  @override
  Map<String, dynamic> toJson() => _$BlogModelToJson(this);
}
