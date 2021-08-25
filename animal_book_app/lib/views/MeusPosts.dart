import 'package:animal_book_app/views/widgets/ItemPost.dart';
import 'package:flutter/material.dart';

class MeusPosts extends StatefulWidget {
  @override
  _MeusPostsState createState() => _MeusPostsState();
}

class _MeusPostsState extends State<MeusPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meus Posts"),
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor:Colors.white,
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushNamed(context, "/novo-post");
        },
      ),
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (_, indice){
            return ItemPost();
        }
      ),
    );
  }
}