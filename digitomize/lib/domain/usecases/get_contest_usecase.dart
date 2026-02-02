import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/contest.dart';
import 'package:digitomize/domain/repositories/contest_repository.dart';

class GetContestsUseCase extends ParamUseCase<List<Contest>, GetContestsParams> {
  final ContestRepository _repo;
  GetContestsUseCase(this._repo);

  @override
  Future<List<Contest>> execute(GetContestsParams params) {
    return _repo.getContests(page: params.page, pageSize: params.pageSize);
  }
}

class GetContestsParams {
  final int page;
  final int pageSize;
  GetContestsParams({required this.page, required this.pageSize});
}