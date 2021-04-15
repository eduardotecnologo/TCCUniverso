import 'package:flutter/material.dart';
import 'package:animal_book/Home.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xffff8c1a),
  accentColor: Color(0xffff9933),
);

void main() {
  runApp(MaterialApp(
      title: "Animal Book",
      home:  Home(),
      theme: temaPadrao,
      debugShowCheckedModeBanner: false,
  ));
}
