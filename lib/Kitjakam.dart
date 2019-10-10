import 'package:flutter/material.dart';

import 'Kitjakams.dart';

void main() => runApp(Kitjakam());

class Kitjakam extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirestoreCRUDPage(),
    );
  }
}