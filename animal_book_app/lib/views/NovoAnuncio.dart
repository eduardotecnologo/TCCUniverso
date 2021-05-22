import 'package:animal_book_app/views/widgets/CustomButtom.dart';
import 'package:flutter/material.dart';

class NovoAnuncio extends StatefulWidget {
  @override
  _NovoAnuncioState createState() => _NovoAnuncioState();
}

class _NovoAnuncioState extends State<NovoAnuncio> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo Post"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:Form(
            key: _formKey,
            child: Column(children: <Widget>[
              //Área da imagens
              //FormField(),
              //Menus Dropdown
              Row(children: <Widget>[
                Text("Estado"),
                Text("Animal"),
              ],),
              //Caixas de textos e botões
              Text("Caixas de textos"),
              CustomButton(
                  texto: "Criar novo post",
                  onPressed: () {
                    if( _formKey.currentState.validate()){

                    }
                  },
                ),
            ],
            ),
          ),
        ),
      ),
    );
  }
}