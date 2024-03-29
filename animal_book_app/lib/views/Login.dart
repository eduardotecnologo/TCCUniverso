import 'package:animal_book_app/views/widgets/CustomButtom.dart';
import 'package:flutter/material.dart';
import 'package:animal_book_app/models/Usuario.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'widgets/CustomInput.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerSenha = new TextEditingController();

  bool _cadastrar = false;
  String _mensagemErro = "";
  String _textBotao = "Entrar";

  // Métodos Cadastrar e Logar
  _cadastrarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.createUserWithEmailAndPassword(
            email: usuario.email,
            password: usuario.senha
            ).then((firebaseUser) {
      // redirecionar para a tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }

  _logarUsuario(Usuario usuario) {
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithEmailAndPassword(
      email: usuario.email,
      password: usuario.senha
      ).then((firebaseUser) {
      // redirecionar para a tela principal
      Navigator.pushReplacementNamed(context, "/");
    });
  }



  // Recuperar os dados dos campos
  _validarCampos() {
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if (email.isNotEmpty && email.contains("@")) {
      if (senha.isNotEmpty && senha.length >= 6) {
        // Configurar um Usuário
        Usuario usuario = Usuario();
        usuario.email = email;
        usuario.senha = senha;
        // Cadastrar o susuário ou logar
        if (_cadastrar) {
          _cadastrarUsuario(usuario);
        } else {
          _logarUsuario(usuario);
        }
      } else {
        setState(() {
          _mensagemErro = "Preencha a senha! digite mais de 6 caracteres!";
        });
      }
    } else {
      setState(() {
        _mensagemErro = "Preencha um E-mail válido";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff56e4c),
        title: Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 32),
                child: Image.asset(
                  "img/logo.png",
                  width: 200,
                  height: 150,
                ),
              ),
              CustomInput(
                controller: _controllerEmail,
                hint: "E-mail",
                autofocus: true,
                type: TextInputType.emailAddress,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(''),
                ],
              ),
              CustomInput(
                  controller: _controllerSenha,
                  hint: "Senha",
                  maxLines: 1,
                  obscure: true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Logar"),
                  Switch(
                      value: _cadastrar,
                      onChanged: (bool valor) {
                        setState(() {
                          _cadastrar = valor;
                          _textBotao = "Entrar";
                          if(_cadastrar){
                            _textBotao = "Cadastrar";
                          }
                        });
                      }),
                  Text("Cadastrar"),
                ],
              ),
              CustomButton(
                texto: _textBotao,
                onPressed: (){
                  _validarCampos();
                },
              ),
              FlatButton(
                child: Text("Encontre um amiguinho"),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/");
                  },
                ),
                FlatButton(
                child: Text("Recuperar senha"),
                onPressed: (){
                  Navigator.pushReplacementNamed(context, "/");
                  },
                ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  _mensagemErro,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
