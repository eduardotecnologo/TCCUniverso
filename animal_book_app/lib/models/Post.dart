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

  Post();

  Post.fromDocumentSnapshot(DocumentSnapshot documentSnapshot){
    this.id = documentSnapshot.id;
    this.estado = documentSnapshot["estado"];
    this.pet = documentSnapshot["pet"];
    this.genero = documentSnapshot["genero"];
    this.castrado = documentSnapshot["castrado"];
    this.porte = documentSnapshot["porte"];
    this.cidade = documentSnapshot["cidade"];
    this.nomePet = documentSnapshot["nomePet"];
    this.nomeAbrigo = documentSnapshot["nomeAbrigo"];
    this.contato = documentSnapshot["contato"];
    this.descricao = documentSnapshot["descricao"];
    this.fotos = List<String>.from(documentSnapshot["fotos"]) ;
  }

  // Construtor nomeado
  Post.generateId(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference posts = db.collection("my_posts");
    this.id = posts.doc().id;
    this.fotos = [];
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map ={
      "id":this.id,
      "estado":this.estado,
      "pet":this.pet,
      "genero":this.genero,
      "castrado":this.castrado,
      "porte":this.porte,
      "cidade":this.cidade,
      "nomePet":this.nomePet,
      "nomeAbrigo":this.nomeAbrigo,
      "contato":this.contato,
      "descricao":this.descricao,
      "fotos":this.fotos
    };
    return map;
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