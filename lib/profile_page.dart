import 'package:flutter/material.dart';
import 'package:minuet_library/components/sidemenu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
      drawer: const Sidemenu(),
      body: const Center(
          child: Column(
        children: [
          Icon(
            Icons.person_rounded,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'bintang',
            style: TextStyle(fontSize: 32),
          ),
          Text('18 Books')
        ],
      )),
    );
  }
}
