import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class AddCommentUseCase extends ParamUseCase<void, AddCommentParams> {
  final BlogRepository _repo;
  AddCommentUseCase(this._repo);

  @override
  Future<void> execute(AddCommentParams params) {
    return _repo.addComment(
      blogId: params.blogId,
      userId: params.userId,
      content: params.content,
    );
  }
}

class AddCommentParams {
  final String blogId;
  final String userId;
  final String content;

  AddCommentParams({
    required this.blogId,
    required this.userId,
    required this.content,
  });
}
