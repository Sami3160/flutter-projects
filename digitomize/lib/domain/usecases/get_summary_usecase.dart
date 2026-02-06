import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/repositories/blog_repository.dart';

class GetSummaryUsecase extends ParamUseCase<String, GetSummaryParams>{
  final BlogRepository _repo;
  GetSummaryUsecase(this._repo);
  @override
  Future<String> execute(GetSummaryParams params) {
    return _repo.summarizeBlog(params.id);
  }
}


class GetSummaryParams {
  final String id;
  GetSummaryParams({required this.id});
}