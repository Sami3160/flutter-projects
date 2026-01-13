import 'package:assigment_1/core/services/auth_service.dart';
import 'package:assigment_1/data/models/login_response.dart';

class AuthProvider {

  //this is one dependency
  final AuthService authService;

  //then we define it in constructor
  AuthProvider(this.authService);
  Future<LoginResponse> login(
    String username,
    String password
  ) async {
    final data=await authService.login(username, password);
    return LoginResponse.fronJson(data);
  }
}