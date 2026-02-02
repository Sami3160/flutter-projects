import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class DeleteBlogUseCase extends ParamUseCase<void, DeleteBlogParams> {
  final BlogRepository _repo;
  DeleteBlogUseCase(this._repo);

  @override
  Future<void> execute(DeleteBlogParams params) {
    return _repo.deleteBlog(userId: params.userId, blogId: params.blogId);
  }
}

class DeleteBlogParams {
  final String userId;
  final String blogId;

  DeleteBlogParams({required this.userId, required this.blogId});
}
