import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:would_you_rather/domain/entities/user.dart';
import 'package:would_you_rather/data/models/user_model.dart';

enum _Key { user }

class LocalStorageService extends GetxService {
  SharedPreferences? _sharedPreferences;
  Future<LocalStorageService> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    return this;
  }

  User? get user {
    final rawJson = _sharedPreferences?.getString(_Key.user.toString());
    if (rawJson == null) {
      return null;
    }
    Map<String, dynamic> map = jsonDecode(rawJson);
    return UserModel.fromJson(map);
  }

  set user(User? value) {
    if (value != null) {
      final userModel = UserModel(id: value.id, name: value.name);
      _sharedPreferences?.setString(
        _Key.user.toString(),
        json.encode(userModel.toJson()),
      );
    } else {
      _sharedPreferences?.remove(_Key.user.toString());
    }
  }
}
