import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String _id;
  String _estado;
  String _pet;
  String _genero;
  String _castrado;
  String _porte;
  String _cidade;
  String _nomePet;
  String _nomeAbrigo;
  String _contato;
  String _descricao;
  List<String> _fotos;

  // Construtor
  Post(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference posts = db.collection("my_posts");
    this.id = posts.doc().id;
    this.fotos = [];
  }

  String get id => _id;
  set id(String value) {
    _id = value;
  }

  String get estado => _estado;
  set estado(String value) {
    _estado = value;
  }

  String get pet => _pet;
  set pet(String value) {
    _pet = value;
  }

  String get genero => _genero;
  set genero(String value) {
    _genero = value;
  }

  String get castrado => _castrado;
  set castrado(String value) {
    _castrado = value;
  }

  String get porte => _porte;
  set porte(String value) {
    _porte = value;
  }

  String get cidade => _cidade;
  set cidade(String value) {
    _cidade = value;
  }

  String get nomePet => _nomePet;
  set nomePet(String value) {
    _nomePet = value;
  }

  String get nomeAbrigo => _nomeAbrigo;
  set nomeAbrigo(String value) {
    _nomeAbrigo = value;
  }

  String get contato => _contato;
  set contato(String value) {
    _contato = value;
  }

  String get descricao => _descricao;
  set descricao(String value) {
    _descricao = value;
  }

  List<String> get fotos => _fotos;
  set fotos(List<String> value) {
    _fotos = value;
  }
}