import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}
class _PostsState extends State<Posts> {
  List<String> itensMenu = [];

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
  @override
  void initState(){
    super.initState();

    _verificarUsuarioLogado();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Text("Tela de posts"),
      ),
    );
  }
}