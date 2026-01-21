import 'package:standard_ecommerce/app/domain/entities/user.dart';
import 'package:standard_ecommerce/app/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String username, String password) async {
    return await repository.login(username, password);
  }
}
