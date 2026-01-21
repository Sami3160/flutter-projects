import 'package:standard_ecommerce/app/data/models/user_model.dart';
import 'package:standard_ecommerce/app/data/providers/api_provider.dart';
import 'package:standard_ecommerce/app/domain/entities/user.dart';
import 'package:standard_ecommerce/app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider provider;

  AuthRepositoryImpl({required this.provider});

  @override
  Future<User> login(String username, String password) async {
    // print('username: $username');
    // print('password: $password');
    final response = await provider.login(username, password);
    // print('Login Response: ${response.body}');
    if (response.status.hasError) {
      throw Exception(response.statusText);
    }
    final userModel = UserModel.fromJson(response.body);
    return User(
      id: userModel.id!,
      username: userModel.username!,
      email: userModel.email!,
      firstName: userModel.firstName!,
      lastName: userModel.lastName!,
      image: userModel.image!,
      token: userModel.token!,
    );
  }
}
