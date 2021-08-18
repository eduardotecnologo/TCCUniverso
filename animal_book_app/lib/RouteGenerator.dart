import 'package:animal_book_app/views/MeusPosts.dart';
import 'package:animal_book_app/views/NovoPost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animal_book_app/views/posts.dart';
import 'package:animal_book_app/views/Login.dart';

class RouteGenerator{
  // Método para gerar as Rotas
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch( settings.name){
      case "/" :
      return MaterialPageRoute(
        builder: (_) => Posts()
        );
        case "/login":
        return MaterialPageRoute(
          builder: (_) => Login()
       );
       case "/meus-posts":
        return MaterialPageRoute(
          builder: (_) => MeusPosts());
       case "/novo-post":
        return MaterialPageRoute(
          builder: (_) => NovoPost());
       default:
       _erroRota();
    }
  }
  static Route<dynamic> _erroRota(){
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Tela não encontrada!"),
            ),
            body: Center(
              child: Text("Tela não encontrada!"),
            ),
        );
      }
    );
  }
}