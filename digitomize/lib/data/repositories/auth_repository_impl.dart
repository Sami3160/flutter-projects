import 'dart:developer' as developer;
import 'package:digitomize/data/providers/network/apis/auth_api.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<User> login({required String email, required String password}) async {
    developer.log('AuthRepository: Attempting login for $email');
    final response = await AuthAPI.login(
      email: email,
      password: password,
    ).request();
    developer.log('AuthRepository: Login response received');

    // Be defensive about token location (root or inside user object)
    final String? token =
        response["token"]?.toString() ??
        (response["user"] is Map
            ? response["user"]["token"]?.toString()
            : null);

    if (token == null || token.isEmpty) {
      developer.log('AuthRepository: Token missing or empty in response');
      throw Exception("Login failed: Authentication token not received");
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    developer.log('AuthRepository: Token saved successfully');
    return User.fromJson(response);
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  @override
  Future<User> signin({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
  }) async {
    developer.log('AuthRepository: Attempting signin for $email');
    final response = await AuthAPI.signin(
      firstname,
      lastname,
      email,
      password,
    ).request();

    final String? token =
        response["token"]?.toString() ??
        (response["user"] is Map
            ? response["user"]["token"]?.toString()
            : null);

    if (token == null || token.isEmpty) {
      developer.log('AuthRepository: Signin failed - no token received');
      throw Exception(
        "Signin failed: Account created but could not log in automatically",
      );
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    developer.log('AuthRepository: Signin success, token saved');
    return User.fromJson(response);
  }


  @override
  Future<User> profile() async {
    developer.log('AuthRepository: Attempting profile');
    final response = await AuthAPI.profile().request();
    developer.log('AuthRepository: Profile response received');
    return User.fromJson(response);
  }
}
