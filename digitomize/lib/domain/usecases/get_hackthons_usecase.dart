import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/hackthon.dart';
import 'package:digitomize/domain/repositories/hackthon_repository.dart';

class GetHackthonsUseCase
    extends ParamUseCase<List<Hackthon>, GetHackthonsParams> {
  final HackthonRepository _repo;
  GetHackthonsUseCase(this._repo);

  @override
  Future<List<Hackthon>> execute(GetHackthonsParams params) {
    return _repo.getHackthons(page: params.page, pageSize: params.pageSize);
  }
}

class GetHackthonsParams {
  final int page;
  final int pageSize;
  GetHackthonsParams({required this.page, required this.pageSize});
}
