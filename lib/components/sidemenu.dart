import 'package:minuet_library/library_page.dart';
import 'package:flutter/material.dart';
import 'package:minuet_library/profile_page.dart';
import 'package:minuet_library/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sidemenu extends StatelessWidget {
  const Sidemenu({super.key});

  Future<String?> getUsername(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    return username ??
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void signout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('username');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        FutureBuilder<String?>(
          future: getUsername(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return DrawerHeader(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bookshelf.png'),
                        fit: BoxFit.cover)),
                child: Text(
                  snapshot.data!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Library'),
          onTap: () {
            // Navigator.pushNamed(
            //     context, MaterialPageRoute.(builder: (context) => BookList()));
            Navigator.pushNamed(context, '/library');
          },
        ),
        ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const ProfilePage()));
              Navigator.pushNamed(context, '/profile');
            }),
        ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text('Sign out'),
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('username');

              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false);
            }),
      ]),
    );
  }
}
