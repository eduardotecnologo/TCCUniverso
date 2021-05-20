import 'package:flutter/material.dart';
import 'package:flutter_test_app/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'CustomInput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = new TextEditingController(text: "edudeveloperctk@gmail.com");
  TextEditingController _controllerSenha = new TextEditingController(text: "123mudar");

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textBotao = "Entrar";

   // Métodos
  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.createUserWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
      ).then((firebaseUser) {
        // Redireciona para tela Principal

      });
  }
  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
      ).then((firebaseUser){
        // Redireciona para tela Principal
      });
  }

  _validarCampos(){
    // Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length > 6){
        // Configurar usuário
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;

        // Cadastrar ou logar
        if(_cadastrar){
          _cadastrarUsuario(usuario);
        }else{
          _logarUsuario(usuario);
        }
      }else{
        setState(() {
          _mensagemErro = "Preencha a senha! mínimo de 6 caractéres.";
        });
      }
    }else{
      setState((){
        _mensagemErro = "Preencha um email válido";
      });
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(""),
    ),
    body: Container(
      padding: EdgeInsets.all(16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  bottom: 32
                  ),
                  child: Image.asset(
                    "img/logo.png",
                    width:200,
                    height:150,
                  ),//Image.asset
                ),// Padding
                CustomInput(
                  controller: _controllerEmail,
                  hint: "E-mail",
                  autofocus: true,
                  type: TextInputType.emailAddress,
                ),// CustomInputo globo

                CustomInput(
                  controller: _controllerSenha,
                  hint: "Senha",
                  obscure: true
                ),// CustomInput
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Logar"),
                    Switch(
                      value: _cadastrar,
                      onChanged: (bool valor){
                        setState((){
                          _cadastrar = valor;
                          _textBotao = "Entrar";
                          if(_cadastrar ){
                              //* Se cadastrar for igual a TRUE = Cadastrar *//
                              _textBotao = "Cadastrar";
                          }
                        });
                      },
                  ),// Switch
                  Text("Cadastrar"),
                  ]
              ),
              RaisedButton(
                child: Text(
                  _textBotao,
                  style: TextStyle(
                    color: Colors.white, fontSize: 20
                  ), // TextStyle
                ),// Text
                color: Color(0xff9c27b0),
                padding: EdgeInsets.fromLTRB(32,16,32,16),
                onPressed: (){
                  _validarCampos();
                },
              ),
              Padding(
                padding: EdgeInsets.only(top:20),
                child: Text(_mensagemErro, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red
                ),),
                )// ElevatedButton
            ],
          ),
        )
      ),
    )
  );
}
}