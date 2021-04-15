import 'package:flutter/material.dart';
import 'package:flutter_test_app/views/Login.dart';
import 'package:firebase_core/firebase_core.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xffff8c1a),
  accentColor: Color(0xffff9933)
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Animal Book",
    home: Login(),
    theme: temaPadrao,
    debugShowCheckedModeBanner: false,
  ));
}
