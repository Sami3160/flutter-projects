import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/blog.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class GetBlogsUseCase extends ParamUseCase<List<Blog>, GetBlogsParams> {
  final BlogRepository _repo;
  GetBlogsUseCase(this._repo);

  @override
  Future<List<Blog>> execute(GetBlogsParams params) {
    return _repo.getBlogs(page: params.page, pageSize: params.pageSize);
  }
}

class GetBlogsParams {
  final int page;
  final int pageSize;
  GetBlogsParams({required this.page, required this.pageSize});
}