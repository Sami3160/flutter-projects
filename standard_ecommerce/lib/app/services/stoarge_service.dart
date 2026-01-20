import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const _tokenKey='token';
  Future<void> saveToken(String token)async{
    final prefs= await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken(tokenKey)async{
    final prefs=await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> clear()async{
    final prefs=await SharedPreferences.getInstance();
    await prefs.clear();
  }
}