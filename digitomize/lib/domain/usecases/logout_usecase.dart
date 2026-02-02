import 'package:digitomize/app/core/usecases/no_param_usecase.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';

class LogoutUseCase extends NoParamUseCase<void> {
  final AuthRepository _repo;
  LogoutUseCase(this._repo);

  @override
  Future<void> execute() {
    return _repo.logout();
  }
}
