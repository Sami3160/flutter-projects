import 'dart:io';
import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class CreateBlogUseCase extends ParamUseCase<void, CreateBlogParams> {
  final BlogRepository _repo;
  CreateBlogUseCase(this._repo);

  @override
  Future<void> execute(CreateBlogParams params) {
    return _repo.createBlog(
      title: params.title,
      content: params.content,
      category: params.category,
      tags: params.tags,
      doc: params.doc,
    );
  }
}

class CreateBlogParams {
  final String title;
  final String content;
  final String category;
  final List<String> tags;
  final File? doc;

  CreateBlogParams({
    required this.title,
    required this.content,
    required this.category,
    required this.tags,
    this.doc,
  });
}
