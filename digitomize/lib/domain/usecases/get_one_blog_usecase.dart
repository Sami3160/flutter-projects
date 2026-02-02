import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class GetOneBlogUseCase extends ParamUseCase<Blog, String> {
  final BlogRepository _repo;
  GetOneBlogUseCase(this._repo);

  @override
  Future<Blog> execute(String blogId) {
    return _repo.getOneBlog(blogId);
  }
}
