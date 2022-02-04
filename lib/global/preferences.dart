import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _prefInstance;

  Future<void> init() async {
    _prefInstance = await SharedPreferences.getInstance();
  }

  Future clearLocalPref() async {
    await _prefInstance?.clear();
  }

  // setters

  Future setUserId(String userId) async =>
      _prefInstance?.setString(_userIdKey, userId);

  // getters

  String? get userId => _prefInstance?.getString(_userIdKey);
}

const String _userIdKey = "userIdKey";
