import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
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
}
