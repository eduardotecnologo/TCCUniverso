import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:animal_book_app/views/widgets/CustomButtom.dart';
import 'package:validadores/Validador.dart';

class NovoPost extends StatefulWidget {
  @override
  _NovoPostState createState() => _NovoPostState();
}

class _NovoPostState extends State<NovoPost> {
  List<File> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  List<DropdownMenuItem<String>> _listaItensDropBichinhos = [];

  final _formKey = GlobalKey<FormState>();

  String _itemSelecionadoEstado;
  String _itemSelecionadoBichinho;

  _selecionarImagemGaleria() async {
    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
      if( imagemSelecionada != null){
        setState((){
          _listaImagens.add( imagemSelecionada );
        });
      }
  }

  // Select Estados
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _carregarItensDropdown();

  }

  _carregarItensDropdown(){

    // Bichinhos
    _listaItensDropBichinhos.add(DropdownMenuItem(child: Text("Cachorro(a)"), value: "pet",));
    _listaItensDropBichinhos.add(DropdownMenuItem(child: Text("Gato(a)"),value: "pet",));
    _listaItensDropBichinhos.add(DropdownMenuItem(child: Text("Passaros"),value: "pet",));

    //Estados
    for( var estado in Estados.listaEstadosSigla ){
      _listaItensDropEstados.add(
        DropdownMenuItem(child: Text(estado), value: estado,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Postagem"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child:Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              //Área da imagens
              FormField<List>(
                initialValue: _listaImagens,
                validator: ( imagens ){
                  if( imagens.length == 0){
                    return "Necessário selecionar uma imagem!";
                  }
                  return null;
                },
                builder: (state){
                  return Column(children: <Widget>[
                    Container(
                      height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _listaImagens.length + 1,
                          itemBuilder: (context, indice){
                            if( indice == _listaImagens.length ){
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: GestureDetector(
                                    onTap: (){
                                      _selecionarImagemGaleria();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[400],
                                      radius: 50,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.grey[100],
                                        ),
                                        Text(
                                          "Adicionar",
                                          style: TextStyle(
                                            color: Colors.grey[100]
                                             ),
                                        )
                                      ],),
                                    ),
                                  ),
                                );
                            }
                            if( _listaImagens.length > 0){
                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: (){
                                  showDialog(
                                    context: context,
                                    builder: (context) => Dialog(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                        Image.file( _listaImagens[indice]),
                                        FlatButton(
                                          child: Text("Excluir"),
                                           textColor: Colors.red,
                                           onPressed: (){
                                             setState(() {
                                             _listaImagens.removeAt(indice);
                                             Navigator.of(context).pop();
                                             });
                                           },),
                                        ],
                                      ),
                                    )
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage( _listaImagens[indice]),
                                  child: Container(
                                    color: Color.fromRGBO(255, 255, 255, 0.4),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.delete, color: Colors.red,)                                ),
                              ),
                            ),
                          );
                        }
                          return Container();
                        }
                      ),
                    ),
                    if( state.hasError )
                    Container(
                      child: Text(
                        "[${state.errorText}]",
                        style: TextStyle(
                          color: Colors.red, fontSize: 14
                        ),
                      ),
                    )
                  ],);
                },
              ),
              //Menus Dropdown
              Row(children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: DropdownButtonFormField(
                      value: _itemSelecionadoEstado,
                      hint: Text("Estados"),
                      style: TextStyle(
                        color:  Colors.black,
                        fontSize: 20,
                        ),
                      items: _listaItensDropEstados,
                      validator: (value){
                        return Validador()
                        .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                        .valido(value);
                      },
                      onChanged: (value){
                        setState(() {
                          _itemSelecionadoEstado = value;
                        });
                      },
                    ),
                    ),
                  ),
                Expanded( // Item selecionado Bichinho
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoBichinho,
                          hint: Text("Pet"),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          items: _listaItensDropBichinhos,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório!")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _itemSelecionadoBichinho = value;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
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