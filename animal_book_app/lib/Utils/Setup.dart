import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Setup {

  static List<DropdownMenuItem<String>> getEstados() {
    List<DropdownMenuItem<String>> listaItensDropEstados = [];
    listaItensDropEstados.add(DropdownMenuItem(child: Text(
      "Região", style: TextStyle(
        color: Color(0xffff56e4c)
      ),),value: null,));

    for( var estado in Estados.listaEstadosSigla ){
      listaItensDropEstados.add(
        DropdownMenuItem(child: Text(estado), value: estado,
      ));
    }
    return listaItensDropEstados;
  }
  static List<DropdownMenuItem<String>> getBichinhos() {
    List<DropdownMenuItem<String>> itensDropBichinhos = [];
    // Mostrar nas categorias
    itensDropBichinhos.add(DropdownMenuItem(child: Text(
        "Amiguinho",
        style: TextStyle(color: Color(0xffff56e4c)),
      ),
      value: null,
    ));

    itensDropBichinhos.add(DropdownMenuItem(
      child: Text("Cão"),value: "cachorro",));
    itensDropBichinhos.add(DropdownMenuItem(child: Text("Gato"),value: "gato",));
    return itensDropBichinhos;
  }

  static List<DropdownMenuItem<String>> getGenero() {
    List<DropdownMenuItem<String>> itensDropGenero = [];
    itensDropGenero.add(DropdownMenuItem(
      child: Text(
        "Genero",
        style: TextStyle(color: Color(0xffff56e4c)),
      ),
      value: null,
    ));
    itensDropGenero.add(DropdownMenuItem(child: Text("Macho"),value: "macho",));
    itensDropGenero.add(DropdownMenuItem(child: Text("Fêmea"),value: "femea",));
    return itensDropGenero;
  }

  static List<DropdownMenuItem<String>> getPorte() {
    List<DropdownMenuItem<String>> itensDropPorte = [];
    itensDropPorte.add(DropdownMenuItem(
      child: Text(
        "Porte",
        style: TextStyle(color: Color(0xffff56e4c)),
      ),
      value: null,
    ));
    itensDropPorte.add(DropdownMenuItem(child: Text("Pequeno"),value: "pequeno",));
    itensDropPorte.add(DropdownMenuItem(child: Text("Médio"),value: "medio",));
    itensDropPorte.add(DropdownMenuItem(child: Text("Grande"),value: "grande",));
    return itensDropPorte;
  }

  static List<DropdownMenuItem<String>> getCastracao() {
      List<DropdownMenuItem<String>> itensDropCastramento = [];

    itensDropCastramento.add(DropdownMenuItem(
      child: Text(
        "Castração",
        style: TextStyle(color: Color(0xffff56e4c)),
      ),
      value: null,
    ));
    itensDropCastramento.add(DropdownMenuItem(child: Text("Sim"),value: "sim",));
    itensDropCastramento.add(DropdownMenuItem(child: Text("Não"),value: "nao",));
    return itensDropCastramento;
  }
}







//############  Acertar categorias em NOAVA POSTAGEM ###############