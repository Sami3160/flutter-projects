


import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';

class LoginUseCase extends ParamUseCase<User, LoginParams>{
  final AuthRepository _repo;
  LoginUseCase(this._repo);
  @override
  Future<User> execute(LoginParams params) {
    return _repo.login(email: params.email, password: params.password);
  }
}


class LoginParams{
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});

}