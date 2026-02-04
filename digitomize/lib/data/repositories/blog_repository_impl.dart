import 'package:digitomize/data/providers/network/apis/blog_api.dart';
import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';
import 'dart:io';

class BlogRepositoryImpl implements BlogRepository {
  @override
  Future<List<Blog>> getBlogs({required int page, required int pageSize}) async {
    final response = await BlogAPI.getBlogs(page: page, pageSize: pageSize).request();
    final List<dynamic> list = response['blogs'] ?? []; 
    return list.map((item) => Blog.fromJson(item)).toList();
  }

  @override
  Future<Blog> getOneBlog(String id) async {
    final response = await BlogAPI.getOneBlog(id).request();
    return Blog.fromJson(response['blogData']);
  }

  @override
  Future<void> createBlog({
    required String title,
    required String content,
    required String category,
    required List<String> tags,
    File? doc,
  }) async {
    await BlogAPI.createBlog(
      title: title,
      content: content,
      category: category,
      tags: tags,
      doc: doc,
    ).request();
  }
  
  @override
  Future<void> addComment({required String blogId, required String userId, required String content}) async{
    await BlogAPI.addComment(blogId: blogId, userId: userId, content: content).request();
  }
  
  @override
  Future<void> deleteBlog({required String userId, required String blogId}) async{
    await BlogAPI.deleteBlog(userId: userId, blogId: blogId).request();
  }
  
  @override
  Future<void> deleteComment({required String blogId, required String commentId}) async{
    await BlogAPI.deleteComment(blogId: blogId, commentId: commentId).request();
  }
  
  @override
  Future<void> updateLike({required String userId, required String blogId}) async{
    await BlogAPI.updateLike(userId: userId, blogId: blogId).request();
  }
}