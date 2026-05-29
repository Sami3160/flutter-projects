import '../entities/user.dart';
import '../repositories/game_repository.dart';

class RegisterUserUseCase {
  final GameRepository _repository;
  RegisterUserUseCase(this._repository);

  Future<User> execute(String name) {
    return _repository.registerUser(name);
  }
}
