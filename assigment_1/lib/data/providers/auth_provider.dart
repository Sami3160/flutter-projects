import 'package:assigment_1/core/services/auth_service.dart';
import 'package:assigment_1/data/models/login_response.dart';

//here we do the api calls
class AuthProvider {

  //this is one dependency
  final AuthService authService;

  //then we define it in constructor
  AuthProvider(this.authService);

  //we take data from authservice and transform it here
  Future<LoginResponse> login(
    String username,
    String password
  ) async {
    final data=await authService.login(username, password);
    return LoginResponse.fronJson(data);
  }
}