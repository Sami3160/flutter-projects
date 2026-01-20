

import 'dart:convert';

import 'package:assigment_1/core/network/api_client.dart';
import 'package:assigment_1/core/network/api_exception.dart';


//here we only define api calls
class AuthService {
  final ApiClient apiClient=ApiClient();
  Future<Map<String, dynamic>> login(
    String username,
    String password,
  )async{
    
    final response=await apiClient.post(
      "https://dummyjson.com/auth/login",
      {
        "username":username,
        "password":password,
        "expiresInMins": 30
      });
      if(response.statusCode!=200){
        throw ApiException('Login Failed');
      }

      return jsonDecode(response.body); 
  }

}