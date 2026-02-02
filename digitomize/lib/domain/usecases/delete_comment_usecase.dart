import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class DeleteCommentUseCase extends ParamUseCase<void, DeleteCommentParams> {
  final BlogRepository _repo;
  DeleteCommentUseCase(this._repo);

  @override
  Future<void> execute(DeleteCommentParams params) {
    return _repo.deleteComment(
      blogId: params.blogId,
      commentId: params.commentId,
    );
  }
}

class DeleteCommentParams {
  final String blogId;
  final String commentId;

  DeleteCommentParams({required this.blogId, required this.commentId});
}
