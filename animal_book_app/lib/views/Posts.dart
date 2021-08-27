import 'package:animal_book_app/Utils/Setup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  String _itemSelecionadoEstado;
  String _itemSelecionadoBichinho;
  String _itemSelecionadoPorte;

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

  _carregarItensDropdown() {
    // Categorias
    _listaItensDropBichinhos = Setup.getBichinhos();
    _listaItensDropGenero = Setup.getGenero();
    _listaItensDropPorte = Setup.getPorte();
    _listaItensDropEstados = Setup.getEstados();
  }

  @override
  void initState(){
    super.initState();

    _carregarItensDropdown();
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
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            // _itemSelecionadoEstado
            Expanded(
              child: DropdownButtonHideUnderline(
                child: Center(
                  child: DropdownButton(
                    iconEnabledColor: Color(0xffff56e4c),
                    value: _itemSelecionadoEstado,
                    items: _listaItensDropEstados,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black
                    ),
                    onChanged: (estado){
                      setState(() {
                      _itemSelecionadoEstado = estado;
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
                      iconEnabledColor: Color(0xffff56e4c),
                      value: _itemSelecionadoBichinho,
                      items: _listaItensDropBichinhos,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      onChanged: (bichinho) {
                        setState(() {
                          _itemSelecionadoBichinho = bichinho;
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
                        });
                      },
                    ),
                  ),
                )),
          ],),
        ],),
      ),
    );
  }
}