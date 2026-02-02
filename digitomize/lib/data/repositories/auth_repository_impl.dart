import 'package:digitomize/data/providers/network/apis/auth_api.dart';
import 'package:digitomize/domain/entities/user.dart';
import 'package:digitomize/domain/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository{
  @override
  Future<User> login({required String email, required String password})async {
    final response=await AuthAPI.login(email:email,password:password).request();
    final String? token=response["token"];
    if(token==null){
      throw Exception("Invalid credentials");
    }
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    return User.fromJson(response);
  }

  @override
  Future<void> logout()async {
    final prefs=await SharedPreferences.getInstance();
    await prefs.remove("token");
  }

  @override
  Future<User> signin({required String firstname, required String lastname, required String email, required String password})async {
    final response=await AuthAPI.signin(firstname, lastname, email, password).request();
    final String? token=response["token"];
    if(token==null){
      throw Exception("Invalid credentials");
    }
    final prefs=await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    return User.fromJson(response);
  }

}