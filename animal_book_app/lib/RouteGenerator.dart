import 'package:animal_book_app/views/MeusAnuncios.dart';
import 'package:animal_book_app/views/NovoAnuncio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animal_book_app/views/Anuncios.dart';
import 'package:animal_book_app/views/Login.dart';

class RouteGenerator{
  // Método para gerar as Rotas
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch( settings.name){
      case "/" :
      return MaterialPageRoute(
        builder: (_) => Anuncios()
        );
        case "/login":
        return MaterialPageRoute(
          builder: (_) => Login()
       );
       case "/meus-anuncios":
        return MaterialPageRoute(
          builder: (_) => MeusAnuncios());
       case "/novo-anuncio":
        return MaterialPageRoute(
          builder: (_) => NovoAnuncio());
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
              child: Text("Tela não encontrada"),
            ),
        );
      }
    );
  }
}