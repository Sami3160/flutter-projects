import 'package:digitomize/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login({
    required String email,
    required String password,
  });
  Future<User> signin({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  });
  Future<void> logout();
}