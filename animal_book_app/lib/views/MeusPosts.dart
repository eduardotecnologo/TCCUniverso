import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:animal_book_app/models/Post.dart';
import 'package:animal_book_app/views/widgets/ItemPost.dart';

class MeusPosts extends StatefulWidget {
  @override
  _MeusPostsState createState() => _MeusPostsState();
}

class _MeusPostsState extends State<MeusPosts> {

  final _controller = StreamController<QuerySnapshot>.broadcast();
      String idUsuarioLogado;

  _recoverUserLogged() async {
     // Recupera usuário logado
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    idUsuarioLogado = usuarioLogado.uid;
  }

  // ignore: missing_return
  Future <Stream<QuerySnapshot>> _addListenerPosts() async {

    await _recoverUserLogged();

    FirebaseFirestore db =  FirebaseFirestore.instance;
    Stream<QuerySnapshot> stream = db
      .collection("my_posts")
      .doc(idUsuarioLogado)
      .collection("posts")
      .snapshots();

      stream.listen((dados) {
        _controller.add( dados );
       });
  }

  _removePost(String idPost){
    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection("my_posts")
      .doc(idUsuarioLogado)
      .collection("posts")
      .doc(idPost)
      .delete().then((_) {
        db.collection("posts")
          .doc(idPost)
          .delete();
      });
  }

  @override
  void initState(){
    super.initState();
    _addListenerPosts();
  }

  @override
  Widget build(BuildContext context) {

    var loadingDatas = Center(
      child: Column(children: <Widget>[
          Text("Carregando Posts"),
          CircularProgressIndicator()
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Posts"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor:Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/novo-post");
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot){

          switch( snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return loadingDatas;
              break;
            case ConnectionState.active:
            case ConnectionState.done:
            // Exibindo mensagem de erro
            if(snapshot.hasError)
              return Text("Erro ao exibir dados!");
            // Recuperando os dados
            QuerySnapshot querySnapshot = snapshot.data;

            return ListView.builder(
                  itemCount: querySnapshot.docs.length,
                  itemBuilder: (context, indice) {
                    List<DocumentSnapshot> posts = querySnapshot.docs?.toList() ?? [];
                    DocumentSnapshot documentSnapshot = posts[indice];
                    Post post = Post.fromDocumentSnapshot(documentSnapshot);
                    return ItemPost(
                      post: post,
                      onPressedRemover: (){
                        showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Confirmar"),
                              content: Text("Deseja mesmo excluir o anúncio?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    "Cancelar",
                                    style: TextStyle(
                                      color: Colors.white
                                    )
                                  ),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                ),
                                FlatButton(
                                  color: Colors.red,
                                  child: Text("Remover",
                                    style: TextStyle(
                                      color: Colors.white
                                      ),
                                  ),
                                onPressed: () {
                                  _removePost(post.id);
                                  Navigator.of(context).pop();
                                },
                              )
                              ]
                            );
                          });
                      },
                    );
                  },
                );
            }
          return Container();
        },
      )
    );
  }
}