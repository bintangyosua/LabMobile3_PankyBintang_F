import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minuet_library/components/sidemenu.dart';
import 'package:minuet_library/library_page.dart';
import 'package:minuet_library/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<String> getUsername(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username')!;
    return username;
  }

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
      body: Center(
          child: Column(
        children: [
          const Icon(
            Icons.person_rounded,
            size: 100,
            color: Colors.grey,
          ),
          FutureBuilder(
              future: getUsername(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data}',
                    style: const TextStyle(fontSize: 32),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
          const SizedBox(
            height: 5,
          ),
          const Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: [
              Chip(
                avatar: Icon(Icons.menu_book),
                label: Text('Library: _ items'),
              ),
              Chip(
                avatar: Icon(Icons.favorite),
                label: Text('Favorite: _ items'),
              ),
              Chip(
                avatar: Icon(Icons.pending_actions),
                label: Text('Wishlist: _ items'),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
