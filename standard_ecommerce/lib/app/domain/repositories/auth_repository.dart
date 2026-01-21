import 'package:standard_ecommerce/app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
}
