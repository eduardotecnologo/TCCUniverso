import 'package:animal_book_app/models/Post.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main.dart';

class DetailsPost extends StatefulWidget {
  Post post;
  DetailsPost(this.post);
  @override
  _DetailsPost createState() => _DetailsPost();
}

class _DetailsPost extends State<DetailsPost> {
  Post _post;
  List<Widget>_getListImages(){
    List<String> listUrlImages = _post.fotos;
    return listUrlImages.map((url) {
      return Container(
        height: 250,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(url),
            fit: BoxFit.fitWidth )
        ),
      );
    }).toList();
  }

  // Call Phone
  _callPhone(String contato) async {
    //contato = "https://www.google.com.br/";
    if( await canLaunch("tel:$contato")){
      await launch("tel:$contato");
    }else{
      print("Não foi possível realisar a ligação!");
    }
  }

  @override
  void initState() {
    super.initState();
    _post = widget.post;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Amimalzinho"),
         backgroundColor: Color(0xfff56e4c),
       ),
       body: Stack(
         children: <Widget>[
           ListView(children: <Widget>[
             SizedBox(
               height: 250,
               child: Carousel(
                 images: _getListImages(),
                 dotSize: 8,
                 dotBgColor: Colors.transparent,
                 dotColor: Colors.white,
                 autoplay: false,
                 dotIncreasedColor: temaPadrao.primaryColor,
               ),
             ),
             Container(
               padding: EdgeInsets.all(16),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                 Text(
                   _post.nomePet,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: temaPadrao.primaryColor
                    )
                   ),
                Text(
                  _post.nomeAbrigo,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w400
                  )
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Divider(),
                  ),
                  Text(
                    "Descrição",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: temaPadrao.primaryColor
                        )
                      ),
                Text(
                  _post.descricao,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400
                    )
                  ),
                   Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(),
                    ),
                    Text("Contato",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: temaPadrao.primaryColor
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 66),
                        child: Text(
                          "${_post.contato}",
                          style: TextStyle(
                            fontSize: 18
                          )
                        )
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Divider(),
                      ),
               ],
               )
             )
           ],),
           Positioned(
             left: 16,
             right: 16,
             bottom: 16,
             child: GestureDetector(
               child: Container(
                 child: Text(
                   "Ligar",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 20
                   ),
                 ),
                 padding: EdgeInsets.all(16),
                 alignment: Alignment.center,
                 decoration: BoxDecoration(
                   color: temaPadrao.primaryColor,
                   borderRadius: BorderRadius.circular(5)
                 ),
                ),
               onTap: (){
                 _callPhone(_post.contato);
               }
             )
          )
         ],
       ),
    );
  }
}