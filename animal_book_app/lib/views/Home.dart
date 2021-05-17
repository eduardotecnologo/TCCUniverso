import 'package:flutter/material.dart';
import 'CustomInput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = new TextEditingController(text: "edudeveloperctk@gmail.com");
  TextEditingController _controllerSenha = new TextEditingController(text: "123mudar");

  bool _cadastrar = false;
  String _mensagemErro = "Preencha a senha!";

  _validarCampos(){
    // Recuperar dados dos campos
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    if(email.isNotEmpty && email.contains("@")){
      if(senha.isNotEmpty && senha.length > 6){
        // Cadastrar ou logar
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
                        });
                      },
                  ),// Switch
                  Text("Cadastrar"),
                  ]
              ),
              ElevatedButton(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white, fontSize: 20
                  ), // TextStyle
                ),// Text
                color: Color(0xff9c27b0),
                padding: EdgeInsets.fromLTRB(32,16,32,16),
                onPressed: (){

                },
              )// ElevatedButton
            ],
          ),
        )
      ),
    )
  );
}
}