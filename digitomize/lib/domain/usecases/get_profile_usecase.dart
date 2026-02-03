import 'package:digitomize/app/core/usecases/no_param_usecase.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';

class GetProfileUsecase extends NoParamUseCase<User> {
  final AuthRepository _repo;
  GetProfileUsecase(this._repo);

  @override
  Future<User> execute() {
    return _repo.profile();
  }
}
