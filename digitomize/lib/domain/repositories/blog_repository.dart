import 'package:digitomize/domain/entities/blog.dart';
import 'dart:io';

abstract class BlogRepository {
  Future<List<Blog>> getBlogs({required int page, required int pageSize});
  Future<Blog> getOneBlog(String id);
  Future<void> createBlog({
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    File? doc,
  });
  Future<void> updateLike({required String userId, required String blogId});
  Future<void> addComment({
    required String blogId,
    required String userId,
    required String content,
  });
  Future<void> deleteComment({
    required String blogId,
    required String commentId,
  });
  Future<void> deleteBlog({required String userId, required String blogId});
  Future<String> summarizeBlog(String id);

}