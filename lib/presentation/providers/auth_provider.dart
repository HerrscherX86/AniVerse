import 'package:flutter/material.dart';
import 'package:aniverse_2/core/db_helper.dart';

// AuthProvider class that extends ChangeNotifier for state management
class AuthProvider with ChangeNotifier {
  // Instance of DBHelper for database operations
  DBHelper _dbHelper = DBHelper();

  // Method to register a new user
  // Returns true if registration is successful, false otherwise
  Future<bool> register(String username, String password) async {
    // Check if the username is already taken
    if (await _dbHelper.isUsernameTaken(username)) {
      return false; // Username is taken, return false
    }
    try {
      // Register the user in the database
      await _dbHelper.registerUser(username, password);
      return true; // Registration successful, return true
    } catch (e) {
      return false; // Registration failed, return false
    }
  }

  // Method to login a user
  // Returns true if login is successful, false otherwise
  Future<bool> login(String username, String password) async {
    // Attempt to login the user with the provided credentials
    final user = await _dbHelper.loginUser(username, password);
    if (user != null) {
      return true; // Login successful, return true
    } else {
      return false; // Login failed, return false
    }
  }
}
