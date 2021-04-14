import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/Home.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xffff8c1a),
  accentColor: Color(0xffff9933)
);

void main() {
  runApp(MaterialApp(
    title: "Animal Book",
    home: Home(),
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}
