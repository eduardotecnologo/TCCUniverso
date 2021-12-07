import 'package:flutter/material.dart';
import 'package:animal_book_app/views/Posts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'RouteGenerator.dart';

final ThemeData temaPadrao = ThemeData(
  primaryColor: Color(0xfff56e4c),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xfff56e4c))
);

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    title: "Animal Book",
    home: Posts(),
    theme: temaPadrao,
    initialRoute: "/",
    onGenerateRoute: RouteGenerator.generateRoute,
    debugShowCheckedModeBanner: false,
  ));
}

