import 'dart:io';
import 'package:digitomize/data/providers/network/api_endpoints.dart';
import 'package:digitomize/data/providers/network/api_provider.dart';
import 'package:digitomize/data/providers/network/api_request_representable.dart';
import 'package:get/get_connect/connect.dart';

enum BlogType {
  create,
  delete,
  getBlogs,
  getOneBlog,
  summarizeBlog,
  updateLike,
  addComment,
  deleteComment,
}

class BlogAPI implements APIRequestRepresentable {
  final BlogType type;
  final String? id;
  final String? title;
  final String? content;
  final String? category;
  final List<String>? tags;
  final File? doc;
  final String? userId;
  final String? blogId;
  final int? page;
  final int? pageSize;
  final String? commentId;

  BlogAPI._({
    required this.type,
    this.id,
    this.title,
    this.content,
    this.category,
    this.tags,
    this.doc,
    this.userId,
    this.blogId,
    this.page,
    this.pageSize,
    this.commentId,
  });

  factory BlogAPI.createBlog({
    String? id,
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    File? doc,
  }) {
    return BlogAPI._(
      type: BlogType.create,
      id: id,
      title: title,
      content: content,
      category: category,
      tags: tags,
      doc: doc,
    );
  }

  factory BlogAPI.deleteBlog({required String userId, required String blogId}) {
    return BlogAPI._(type: BlogType.delete, userId: userId, blogId: blogId);
  }

  factory BlogAPI.getBlogs({int page = 1, int pageSize = 10}) {
    return BlogAPI._(type: BlogType.getBlogs, page: page, pageSize: pageSize);
  }

  factory BlogAPI.getOneBlog(String id) {
    return BlogAPI._(type: BlogType.getOneBlog, id: id);
  }

  factory BlogAPI.updateLike({required String userId, required String blogId}) {
    return BlogAPI._(type: BlogType.updateLike, userId: userId, blogId: blogId);
  }

  factory BlogAPI.addComment({
    required String blogId,
    required String userId,
    required String content,
  }) {
    return BlogAPI._(
      type: BlogType.addComment,
      blogId: blogId,
      userId: userId,
      content: content,
    );
  }

  factory BlogAPI.deleteComment({
    required String blogId,
    required String commentId,
  }) {
    return BlogAPI._(
      type: BlogType.deleteComment,
      blogId: blogId,
      commentId: commentId,
    );
  }
  factory BlogAPI.summarizeBlog({required String id}){
    return BlogAPI._(type: BlogType.summarizeBlog, id: id);
  }

  @override
  String get endpoint => ApiEndpoints.baseUrl;

  @override
  String get path {
    switch (type) {
      case BlogType.create:
        return "/blog/create";
      case BlogType.delete:
        return "/blog/delete";
      case BlogType.getBlogs:
        return "/blog/getBlogs";
      case BlogType.getOneBlog:
        return "/blog/getOneBlog";
      case BlogType.updateLike:
        return "/blog/updateLike";
      case BlogType.addComment:
        return "/blog/addComment";
      case BlogType.deleteComment:
        return "/blog/deleteComment";
      case BlogType.summarizeBlog:
        return "/blog/getBlogSummary";
    }
  }

  @override
  HTTPMethod get method {
    switch (type) {
      case BlogType.getBlogs:
      case BlogType.getOneBlog:
      case BlogType.summarizeBlog:
      case BlogType.updateLike:
        return HTTPMethod.get;
      default:
        return HTTPMethod.post;
    }
  }

  @override
  Map<String, String>? get headers {
    if (type == BlogType.create && doc != null) {
      return null; // GetConnect handles multi-part boundary when body is FormData
    }
    return {HttpHeaders.contentTypeHeader: 'application/json'};
  }

  @override
  Map<String, String>? get query {
    switch (type) {
      case BlogType.getBlogs:
        return {
          "page": page?.toString() ?? "1",
          "pageSize": pageSize?.toString() ?? "10",
        };
      case BlogType.getOneBlog:
      case BlogType.summarizeBlog:
        return {"_id": id ?? ""};
      case BlogType.updateLike:
        return {"user_id": userId ?? "", "blog_id": blogId ?? ""};
      default:
        return null;
    }
  }

  @override
  get body {
    switch (type) {
      case BlogType.create:
        if (doc != null) {
          return FormData({
            if (id != null) "_id": id,
            "title": title,
            "content": content,
            "category": category,
            "tags": tags,
            "doc": MultipartFile(doc!, filename: doc!.path.split('/').last),
          });
        }
        return {
          if (id != null) "_id": id,
          "title": title,
          "content": content,
          "category": category,
          "tags": tags,
        };
      case BlogType.delete:
        return {"user_id": userId, "blog_id": blogId};
      case BlogType.addComment:
        return {"blog_id": blogId, "user_id": userId, "content": content};
      case BlogType.deleteComment:
        return {"blog_id": blogId, "comment_id": commentId};
      default:
        return null;
    }
  }

  @override
  Future request() {
    return APIProvider.instance.request(this);
  }

  @override
  String get url => endpoint + path;
}
