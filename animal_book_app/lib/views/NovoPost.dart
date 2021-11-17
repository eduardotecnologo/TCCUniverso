import 'dart:io';
import 'package:flutter/material.dart';
import 'package:animal_book_app/Utils/Setup.dart';
import 'package:animal_book_app/models/Post.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animal_book_app/views/widgets/CustomButtom.dart';
import 'package:animal_book_app/views/widgets/CustomInput.dart';
import 'package:validadores/Validador.dart';

class NovoPost extends StatefulWidget {
  @override
  _NovoPostState createState() => _NovoPostState();
}

class _NovoPostState extends State<NovoPost> {
  List<File> _listaImagens = [];
  List<DropdownMenuItem<String>> _listaItensDropEstados = [];
  List<DropdownMenuItem<String>> _listaItensDropBichinhos = [];
  List<DropdownMenuItem<String>> _listaItensDropGenero = [];
  List<DropdownMenuItem<String>> _listaItensDropCastramento = [];
  List<DropdownMenuItem<String>> _listaItensDropPorte = [];

  final _formKey = GlobalKey<FormState>();
  Post _post;
  BuildContext _dialogContext;

  String _itemSelecionadoEstado;
  String _itemSelecionadoBichinhos;
  String _itemSelecionadoGenero;
  String _itemSelecionadoCastramento;
  String _itemSelecionadoPorte;

  _selecionarImagemGaleria() async {
    File imagemSelecionada = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imagemSelecionada != null) {
      setState(() {
        _listaImagens.add(imagemSelecionada);
      });
    }
  }

  _openDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  height: 20,),
                Text("Salvando Posts...")
              ],),
          );
        });
  }

  // Save Post
  _savePost() async {
    _openDialog(_dialogContext);
    // Upload Images in Storage
    await _uploadImages();

    // Save Posts in Firestore
    FirebaseAuth auth = FirebaseAuth.instance;
    User usuarioLogado = await auth.currentUser;
    String idUsuarioLogado = usuarioLogado.uid;

    FirebaseFirestore db = FirebaseFirestore.instance;
    db
        .collection("my_posts")
        .doc(idUsuarioLogado)
        .collection("posts")
        .doc(_post.id)
        .set(_post.toMap()).then((_) {

        // Save Posts
        db
          .collection("posts")
          .doc( _post.id )
          .set( _post.toMap()).then((_) {
            Navigator.pop(_dialogContext);
            Navigator.pop(context);
          });
      });
    // Upload Posts in Firestorage
  }

  Future _uploadImages() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference rootFolder = storage.ref();

    for (var imagem in _listaImagens) {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();
      Reference file = rootFolder
        .child("my_posts")
        .child( _post.id )
        .child( nameImage );

      //Upload Refactory
      UploadTask uploadTask = file.putFile(imagem);
      // StorageUploadTask uploadTask = file.putFile(imagem);
      // StorageTaskSnapshot taskSnapshot = await UploadTask.onComplete;
      String url = await (await uploadTask).ref.getDownloadURL();
      _post.fotos.add(url);
    }
  }

  // Select Estados
  @override
  void initState() {
    super.initState();
    _carregarItensDropdown();
    _post = Post.generateId();
  }

  _carregarItensDropdown() {
    // Categorias
    _listaItensDropBichinhos = Setup.getBichinhos();
    _listaItensDropGenero = Setup.getGenero();
    _listaItensDropPorte = Setup.getPorte();
    _listaItensDropEstados = Setup.getEstados();
    _listaItensDropCastramento = Setup.getCastracao();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff56e4c),
        title: Text("Nova Postagem"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                //Área da imagens
                FormField<List>(
                  initialValue: _listaImagens,
                  validator: (imagens) {
                    if (imagens.length == 0) {
                      return "Necessário selecionar uma imagem!";
                    }
                    return null;
                  },
                  builder: (state) {
                    return Column(
                      children: <Widget>[
                        Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: _listaImagens.length + 1,
                              itemBuilder: (context, indice) {
                                if (indice == _listaImagens.length) {
                                  return Padding(
                                    padding:EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
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
                                                  color: Colors.grey[100]),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }
                                if (_listaImagens.length > 0) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: GestureDetector(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                                  child: Column(
                                                    mainAxisSize:MainAxisSize.min,
                                                    children: <Widget>[
                                                      Image.file(_listaImagens[indice]),
                                                      FlatButton(
                                                        child: Text("Excluir"),
                                                        textColor: Colors.red,
                                                        onPressed: () {
                                                          setState(() {
                                                            _listaImagens.removeAt(indice);
                                                            Navigator.of(context).pop();
                                                          });
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ));
                                      },
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:FileImage(_listaImagens[indice]),
                                        child: Container(
                                            color: Color.fromRGBO(255, 255, 255, 0.4),
                                            alignment: Alignment.center,
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )),
                                      ),
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        if (state.hasError)
                          Container(
                            child: Text(
                              "[${state.errorText}]",
                              style: TextStyle(color: Colors.red, fontSize: 14),
                            ),
                          )
                      ],
                    );
                  },
                ),
                //Menus Dropdown 01
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoEstado,
                          hint: Text("Estado"),
                          onSaved: (estado) {
                            _post.estado = estado;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          items: _listaItensDropEstados,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório!")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _itemSelecionadoEstado = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      // Item selecionado Bichinho
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoBichinhos,
                          hint: Text("Pet"),
                          onSaved: (pet) {
                            _post.pet = pet;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
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
                              _itemSelecionadoBichinhos = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      // Item selecionado Genero
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoGenero,
                          hint: Text("Genero"),
                          onSaved: (genero) {
                            _post.genero = genero;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          items: _listaItensDropGenero,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório!")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _itemSelecionadoGenero = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //Menus Dropdown 02
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoCastramento,
                          hint: Text("Castramento"),
                          onSaved: (castrado) {
                            _post.castrado = castrado;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          items: _listaItensDropCastramento,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório!")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _itemSelecionadoCastramento = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      // Item selecionado Porte
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: DropdownButtonFormField(
                          value: _itemSelecionadoPorte,
                          hint: Text("Porte"),
                          onSaved: (porte) {
                            _post.porte = porte;
                          },
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          items: _listaItensDropPorte,
                          validator: (value) {
                            return Validador()
                                .add(Validar.OBRIGATORIO,
                                    msg: "Campo Obrigatório!")
                                .valido(value);
                          },
                          onChanged: (value) {
                            setState(() {
                              _itemSelecionadoPorte = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                //Caixas de texto Cidade
                Padding(
                  padding: EdgeInsets.only(bottom: 15, top: 15),
                  child: CustomInput(
                    hint: "Cidade",
                    onSaved: (cidade) {
                      _post.cidade = cidade;
                    },
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                          .valido(value);
                    },
                    controller: null,
                  ),
                ),
                //Caixas de texto Nome
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: CustomInput(
                    hint: "Nome do Pet",
                    onSaved: (nomePet) {
                      _post.nomePet = nomePet;
                    },
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                          .valido(value);
                    },
                    controller: null,
                  ),
                ),
                //Caixas de texto Nome
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: CustomInput(
                    hint: "Nome do Abrigo",
                    onSaved: (nomeAbrigo) {
                      _post.nomeAbrigo = nomeAbrigo;
                    },
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                          .valido(value);
                    },
                    controller: null,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: CustomInput(
                    hint: "Contato",
                    onSaved: (contato) {
                      _post.contato = contato;
                    },
                    type: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                          .valido(value);
                    },
                    controller: null,
                  ),
                ),
                //Caixas de texto Descrição
                Padding(
                  padding: EdgeInsets.only(bottom: 15),
                  child: CustomInput(
                    hint: "Descrição (200 caractéres)",
                    onSaved: (descricao) {
                      _post.descricao = descricao;
                    },
                    maxLines: 1,
                    validator: (value) {
                      return Validador()
                          .add(Validar.OBRIGATORIO, msg: "Campo Obrigatório!")
                          .maxLength(200, msg: "Máximo de 200 caractéres")
                          .valido(value);
                    },
                    controller: null,
                  ),
                ),
                CustomButton(
                  texto: "Cadastrar novo animalzinho",
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      // Save Fields
                      _formKey.currentState.save();

                      // Setup Context Dialog
                      _dialogContext = context;

                      //Save Post
                      _savePost();
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
