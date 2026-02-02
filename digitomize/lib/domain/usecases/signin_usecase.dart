import 'package:digitomize/app/core/usecases/pram_usecase.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';

class SigninUseCase extends ParamUseCase<User, SigninParams> {
  final AuthRepository _repo;
  SigninUseCase(this._repo);

  @override
  Future<User> execute(SigninParams params) {
    return _repo.signin(
      firstname: params.firstname,
      lastname: params.lastname,
      email: params.email,
      password: params.password,
    );
  }
}

class SigninParams {
  final String firstname;
  final String lastname;
  final String email;
  final String password;

  SigninParams({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
  });
}
