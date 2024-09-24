import 'package:flutter/material.dart';
import 'package:minuet_library/components/sidemenu.dart';
import 'package:minuet_library/library_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Sidemenu(),
    );
  }
}
