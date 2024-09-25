import 'package:flutter/material.dart';
import 'package:minuet_library/library_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Minuet Library',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        )),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // shrinkWrap: true,
          // padding: const EdgeInsets.all(20.0),
          children: [
            const SizedBox(height: 10),
            const Center(
                child: Text(
              'Sign In',
              style: TextStyle(fontSize: 28),
            )),
            const SizedBox(height: 10),
            const Text('Masuk dengan mengisi email dan password!'),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
                prefixIcon: Icon(Icons.email),
              ),
              controller: _usernameController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)),
              controller: _passwordController,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  _login();
                },
                child: const Text('Masuk'),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )),
    );
  }

  void _login() async {
    if (_usernameController.text != 'bintang' ||
        _passwordController.text != '123456') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau Password yang anda masukkan salah!'),
        ),
      );
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _usernameController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BookList()));
    }
  }
}
