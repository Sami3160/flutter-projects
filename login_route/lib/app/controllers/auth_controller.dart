import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  String? token;
  static const String _token_key = "jwt_token";

  @override
  void onInit() {
    super.onInit();
    _loadToken();
  }

  //loign
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse("https://dummyjson.com/auth/login"),headers: {
          "Content-Type": "application/json"
        },body: jsonEncode({
          'username':email,
          'password':password,
          'expiresInMins': 30,
        })
      );

      if (response.statusCode == 200) {
        final data=jsonDecode( response.body);
        // Get.snackbar("Info", data.toString());
        token=data['accessToken'];
        await _saveToken(token!);
        isLoggedIn.value = true;
        Get.offAllNamed("/home");
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      Get.snackbar("Error", "Login failed$e");
    } finally {
      isLoading.value = false;
    }
  }




  //signup
  Future<void> signup(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse("https://dummyjson.com/auth/signup"),headers: {
          "Content-Type": "application/json"
        },body: jsonEncode({
          'email':email,
          'password':password
        })
      );

      if (response.statusCode == 200) {
        final data=jsonDecode( response.body);
        token=data['token'];
        await _saveToken(token!);
        isLoggedIn.value = true;
        Get.offAllNamed("/home");
      } else {
        throw Exception('Failed to load album');
      }
    } catch (e) {
      Get.snackbar("Error", "Signin failed");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_token_key, token);
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString(_token_key);

    if(token!=null){
      isLoggedIn.value=true;
      Get.offAllNamed('/home');
    }
  }

  void logout() async{
    token=null;
    final prefs=await SharedPreferences.getInstance();
    prefs.remove(_token_key);
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }
}
