import 'package:booklet_admin/Screens/HomePage.dart';
import 'package:booklet_admin/Screens/UserApproval.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BookletAdmin());
}

class BookletAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
