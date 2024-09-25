import 'package:flutter/material.dart';
import 'package:minuet_library/library_page.dart';
import 'package:minuet_library/login_page.dart';
import 'package:minuet_library/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minuet Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/library': (context) => BookList(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
