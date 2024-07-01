import 'package:aniverse_2/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aniverse_2/presentation/providers/auth_provider.dart';
import 'dart:ui';  // Needed for BackdropFilter

// Screen for user authentication (login/register)
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Controllers for username and password input fields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State variable to toggle between login and register forms
  bool _isLogin = true;

  // Method to toggle between login and register forms
  void _toggleForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  // Method to handle form submission
  void _submit() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    bool success;
    if (_isLogin) {
      // Attempt to login the user
      success = await Provider.of<AuthProvider>(context, listen: false).login(username, password);
    } else {
      // Attempt to register the user
      success = await Provider.of<AuthProvider>(context, listen: false).register(username, password);
    }

    if (success) {
      // Navigate to the main screen on successful login/register
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // Show error message on failed login/register
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isLogin ? 'Login failed' : 'Registration failed: Username might be taken')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/K1U.png',
            fit: BoxFit.cover,
          ),
          // Centered form with glassmorphic effect
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 24.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                  ),
                  // Form content
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Form title (Login/Register)
                      Text(
                        _isLogin ? 'Login' : 'Register',
                        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      // Username input field
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Password input field
                      TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.6),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      // Submit button (Login/Register)
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          _isLogin ? 'Login' : 'Register',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                      // Toggle form button
                      TextButton(
                        onPressed: _toggleForm,
                        child: Text(
                          _isLogin ? 'Don\'t have an account? Register' : 'Already have an account? Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
