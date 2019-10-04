import 'package:flutter/material.dart';
import 'package:plakad1/Sign-In.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:  ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPageV2(),
    );
  }
}
