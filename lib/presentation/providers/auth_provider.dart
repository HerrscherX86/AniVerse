import 'package:flutter/material.dart';
import 'package:aniverse_2/core/db_helper.dart';

class AuthProvider with ChangeNotifier {
  DBHelper _dbHelper = DBHelper();

  Future<bool> register(String username, String password) async {
    if (await _dbHelper.isUsernameTaken(username)) {
      return false;
    }
    try {
      await _dbHelper.registerUser(username, password);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login(String username, String password) async {
    final user = await _dbHelper.loginUser(username, password);
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
