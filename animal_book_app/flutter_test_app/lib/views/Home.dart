import 'package:flutter/material.dart';

import 'CustomInput.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerSenha = new TextEditingController();

  bool _cadastrar = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(""),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding:EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    "img/logo.png",
                    width:200,
                    height:150,
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
                  obscure: true
                ),
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
                  }),
                  Text("Cadastrar"),
                ],
              ),
              RaisedButton(
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white, fontSize: 20
                  ),
                ),
                color: Color(0xffff8c1a),
                padding: EdgeInsets.fromLTRB(32, 16, 32, 16),
                onPressed: (){

                },
              )
            ],),
          )
        ),
      ),
    );
  }
}
