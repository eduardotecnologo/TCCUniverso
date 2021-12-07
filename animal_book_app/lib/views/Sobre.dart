import 'package:flutter/material.dart';

class Sobre extends StatefulWidget {
  //const Sobre({ Key? key }) : super(key: key);

  @override
  _SobreState createState() => _SobreState();
}

class _SobreState extends State<Sobre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff56e4c),
        title: Text("Sobre AnimalBook"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SizedBox(
              width: 350,
              height: 1200,
              child: Text('A aplicação terá a função de facilitar o contato de pessoas com ONGs e/ou pessoas que tenham a intenção de ajudar com doações de insumos para abrigos e na divulgação de animais para adoção, o App será a gratuito sendo necessário o cadastro apenas para uma rastreabilidade das informações postadas, não sendo necessário para visualização das postagens. Os aplicativos mobile tem a vantagem de aumentar a acessibilidade de utilização, independente da sua localidade com o foco na experiencia do usuário,diferentemente de aplicações web ou desktop não adaptados para visualização em dispositivos com telas menores. Empresas que utilizam aplicações mobile aumentam as chances de capitação de usuários em comparação com outras plataformas, e esse objetivo se aplica ao AnimalBook, tornando acessível a todos de forma rápida e a qualquer momento.',
              textAlign: TextAlign.center,
              maxLines: 60,
              style: TextStyle(
                fontSize: 20,
                color: Color(0xfff56e4c),
              ),
            )
          ),
        )
      ),
      ],
    ));
  }
}