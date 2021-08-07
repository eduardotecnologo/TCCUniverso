import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Anuncios extends StatefulWidget {
  @override
  _AnunciosState createState() => _AnunciosState();
}
class _AnunciosState extends State<Anuncios> {
  List<String> itensMenu = [];

  _escolhaMenuItem(String itemEscolhido){
    switch( itemEscolhido ){
      case "Meus posts" :
        Navigator.pushNamed(context, "/meus-anuncios");
        break;
      case "Entrar / Cadastrar":
        Navigator.pushNamed(context, "/login");
        break;
      case "Sair":
      _deslogarUsuario();
        break;
    }
  }

  _deslogarUsuario() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await auth.signOut();
        Navigator.pushNamed(context, "/login");
  }

  Future _verificarUsuarioLogado() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;

      if( usuarioLogado == null){
        itensMenu = ["Entrar / Cadastrar"
        ];
      }else{
        itensMenu = ["Meus anúncios","Sair"];
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
        child: Text("Encontre um amiguinho(a)"),
      ),
    );
  }
}