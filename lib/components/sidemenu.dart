import 'package:minuet_library/library_page.dart';
import 'package:flutter/material.dart';
import 'package:minuet_library/about_page.dart';
import 'package:minuet_library/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        DrawerHeader(
          decoration:
              BoxDecoration(color: Theme.of(context).colorScheme.primary),
          child: const Text(
            'Sidemenu',
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => BookList()));
          },
        ),
        ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutPage()));
            }),
        ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign out'),
            onTap: () async {
              // SharedPreferences prefs = await SharedPreferences.getInstance();
              // await prefs.setBool('isLoggedIn', false);

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
            }),
      ]),
    );
  }
}
