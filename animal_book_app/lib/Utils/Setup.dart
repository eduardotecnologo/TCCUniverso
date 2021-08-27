import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';

class Setup {
  static List<DropdownMenuItem<String>>getBichinhos(){
    List<DropdownMenuItem<String>> itensDropBichinhos = [];

    // Bichinhos
    itensDropBichinhos.add(DropdownMenuItem(child: Text("Cão"),value: "cachorro",));
    itensDropBichinhos.add(DropdownMenuItem(child: Text("Gato"),value: "gato",));
    return itensDropBichinhos;
  }

   static List<DropdownMenuItem<String>> getGenero() {
    List<DropdownMenuItem<String>> itensDropGenero = [];

    // Genero
    itensDropGenero.add(DropdownMenuItem(child: Text("Macho"),value: "macho",));
    itensDropGenero.add(DropdownMenuItem(child: Text("Fêmea"),value: "femea",));
    return itensDropGenero;
  }

  static List<DropdownMenuItem<String>> getPorte() {
    List<DropdownMenuItem<String>> itensDropPorte = [];

    // Genero
    itensDropPorte.add(DropdownMenuItem(child: Text("Pequeno"),value: "pequeno",));
    itensDropPorte.add(DropdownMenuItem(child: Text("Médio"),value: "medio",));
    itensDropPorte.add(DropdownMenuItem(child: Text("Grande"),value: "grande",));
    return itensDropPorte;
  }



}