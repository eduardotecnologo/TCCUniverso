import 'dart:async';
import 'package:animal_book_app/main.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:animal_book_app/views/widgets/ItemPost.dart';
import 'package:animal_book_app/Utils/Setup.dart';
import 'package:animal_book_app/models/Post.dart';


class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}
class _PostsState extends State<Posts> {
  List<String> itensMenu = [];
  List<DropdownMenuItem<String>> _listaItensDropBichinhos;
  List<DropdownMenuItem<String>> _listaItensDropGenero;
  List<DropdownMenuItem<String>> _listaItensDropPorte;
  List<DropdownMenuItem<String>> _listaItensDropEstados;

  final _controller = StreamController<QuerySnapshot>.broadcast();

  String _itemSelecionadoEstado;
  String _itemSelecionadoBichinhos;
  String _itemSelecionadoPorte;
  String _itensDropGenero;

  _escolhaMenuItem(String itemEscolhido){
    switch( itemEscolhido ){
      case "Meus Posts" :
        Navigator.pushNamed(context, "/meus-posts");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Sair":
      _deslogarUsuario();
        break;
    }
  }

  // Sair da conta
  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
        Navigator.pushNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    // ignore: await_only_futures
    User usuarioLogado = await auth.currentUser;

      if( usuarioLogado == null){
        itensMenu = [
          "Entrar / Cadastrar"
        ];
      }else{
        itensMenu = [
          "Meus Posts","Sair"
          ];
      }
  }

  _carregarItensDropdown() {
    // Categorias
    _listaItensDropBichinhos = Setup.getBichinhos();
    _listaItensDropGenero = Setup.getGenero();
    _listaItensDropPorte = Setup.getPorte();
    _listaItensDropEstados = Setup.getEstados();
  }

  // ignore: missing_return
  Future<Stream<QuerySnapshot>>_addListenerPosts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
        .collection("posts")
        .snapshots();

    stream.listen((dados) {
      _controller.add(dados);
    });
  }

   // ignore: missing_return
   Future<Stream<QuerySnapshot>> _filterPosts() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Query query = db.collection("posts");

    if(_itemSelecionadoEstado != null){
      query = query.where("estado", isEqualTo: _itemSelecionadoEstado);
      print(_itemSelecionadoEstado);

    }
     if(_itemSelecionadoBichinhos != null){
      query = query.where("pet", isEqualTo: _itemSelecionadoBichinhos);
      print(_itemSelecionadoBichinhos);
    }
    if(_itemSelecionadoPorte != null){
      query = query.where("porte", isEqualTo: _itemSelecionadoPorte);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((dados) {
      _controller.add(dados);
    });
  }


  @override
  void initState(){
    super.initState();

    _carregarItensDropdown();
    _verificarUsuarioLogado();
    _addListenerPosts();
    _filterPosts();
  }

  @override
  Widget build(BuildContext context) {
    var loadingDatas = Center(
      child: Column(
        children: <Widget>[
          Text("Carregando Posts"),
          CircularProgressIndicator()
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Animal Book"),
        elevation: 0,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context){
              return itensMenu.map((String item){
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                  );
              }).toList();
            },
          )
        ],
      ),
      body: Container(
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            // _itemSelecionadoEstado
            Expanded(
              child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                    iconEnabledColor: temaPadrao.primaryColor,
                    value: _itemSelecionadoEstado,
                    items: _listaItensDropEstados,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                    onChanged: (estado) {
                      setState(() {
                      _itemSelecionadoEstado = estado;
                      _filterPosts();
                      });
                    },
                  ),
                ),
              )
            ),
            Container(
                  color: Colors.grey[200],
                  width: 2,
                  height: 60,
                ),
            // _itemSelecionadoBichinho
            Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: temaPadrao.primaryColor,
                      value: _itemSelecionadoBichinhos,
                      items: _listaItensDropBichinhos,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black
                        ),
                      onChanged: (pet) {
                        setState(() {
                          _itemSelecionadoBichinhos = pet;
                          _filterPosts();
                        });
                      },
                    ),
                  ),
                )
              ),
              Container(
                color: Colors.grey[200],
                width: 2,
                height: 60,
              ),
              // _itemSelecionadoPorte
                Expanded(
                    child: DropdownButtonHideUnderline(
                  child: Center(
                    child: DropdownButton(
                      iconEnabledColor: Color(0xffff56e4c),
                      value: _itemSelecionadoPorte,
                      items: _listaItensDropPorte,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      onChanged: (porte) {
                        setState(() {
                          _itemSelecionadoPorte = porte;
                          _filterPosts();
                        });
                      },
                    ),
                  ),
                )
              ),
          ],),
          // Listagem de Posts
          StreamBuilder(
            stream: _controller.stream,
            builder: (BuildContext context, AsyncSnapshot snapshot){
              switch( snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                return loadingDatas;
                    break;
                case ConnectionState.active:
                case ConnectionState.done:
                // Exibindo mensagem de erro
                    if (snapshot.hasError) return Text("Erro ao exibir dados!");

                  QuerySnapshot querySnapshot = snapshot.data;

                  if( querySnapshot.docs.length == 0){
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: Text("Nehum animalzinho! :( ",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: querySnapshot.docs.length,
                      itemBuilder: (_, indice){
                        List<DocumentSnapshot> posts = querySnapshot.docs?.toList() ?? [];
                        DocumentSnapshot documentSnapshot = posts[indice];
                        Post post = Post.fromDocumentSnapshot(documentSnapshot);
                        return ItemPost(
                            post: post,
                            onTapItem: (){
                              Navigator.pushNamed(
                                context,
                                "/datails-post",
                                arguments: post
                                );
                            },
                          );
                      }
                    ),
                  );
                }
              return Container();
            },
          )
        ],),
      ),
    );
  }
}