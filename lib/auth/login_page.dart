import 'package:flutter/material.dart';
import 'package:pt3_mobile/screen/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";
  bool isLoginSuccess = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 150),

              const Text(
                "Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Login untuk mengakses lebih banyak fitur",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),

              const SizedBox(height: 50),

              _usernameField(),
              const SizedBox(height: 15),
              _passwordField(),

              const SizedBox(height: 30),

              _loginButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET TEXT FIELD ---

  Widget _usernameField() {
    return TextFormField(
      enabled: true,
      onChanged: (value) {
        username = value;
      },
      decoration: InputDecoration(
        hintText: 'Username',
        prefixIcon: const Icon(Icons.person_outline),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      enabled: true,
      onChanged: (value) {
        password = value;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        prefixIcon: const Icon(Icons.lock_outline),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 10.0,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
        ),
      ),
    );
  }

  // --- WIDGET TOMBOL LOGIN ---

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onPressed: () {
        String text = "";
        if (username == "Fulan" && password == "Fulan") {
          setState(() {
            text = "Login sukses";
            isLoginSuccess = true;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return HomePage(username: username);
              },
            ),
          );
        } else {
          setState(() {
            text = "Login gagal";
            isLoginSuccess = false;
          });
        }

        SnackBar snackBar = SnackBar(content: Text(text));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
