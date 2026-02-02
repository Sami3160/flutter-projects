import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class UpdateLikeUseCase extends ParamUseCase<void, UpdateLikeParams> {
  final BlogRepository _repo;
  UpdateLikeUseCase(this._repo);

  @override
  Future<void> execute(UpdateLikeParams params) {
    return _repo.updateLike(userId: params.userId, blogId: params.blogId);
  }
}

class UpdateLikeParams {
  final String userId;
  final String blogId;

  UpdateLikeParams({required this.userId, required this.blogId});
}
