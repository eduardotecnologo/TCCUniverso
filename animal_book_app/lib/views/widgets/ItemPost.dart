import 'package:flutter/material.dart';
import 'package:animal_book_app/models/Post.dart';

// ignore: must_be_immutable
class ItemPost extends StatelessWidget {

  Post post;
  VoidCallback onTapItem;
  VoidCallback onPressedRemover;

  ItemPost(
    {
      @required this.post,
      this.onTapItem,
      this.onPressedRemover
    });

      @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTapItem,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(children: <Widget>[
            //Image
            SizedBox(
              width: 100,
              height: 100,
              child: Image.network(
                post.fotos[0],
                fit: BoxFit.cover,
              ),
            ),
            //Name Abrigo e do animal
            Expanded(
              flex: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    Text(
                      post.nomeAbrigo,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                      ),
                      Text(
                      post.nomePet,
                      style:
                          TextStyle(
                            fontSize: 18,
                            fontWeight:
                            FontWeight.bold),
                    ),
                    Text(post.estado),
                  ],
                  ),
                ),
              ),
            Expanded(
              flex: 1,
                child: FlatButton(
                  color: Colors.orange,
                  padding: EdgeInsets.all(10),
                  onPressed: this.onPressedRemover,
                  child: Icon(Icons.edit,color: Colors.white,),
                ),
              ),
              Expanded(
              flex: 1,
                child: FlatButton(
                  color: Colors.white,
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.delete,color: Colors.white,),
                ),
              ),
              if(this.onPressedRemover != null) Expanded(
                flex: 1,
                child: FlatButton(
                  color: Colors.red,
                  padding: EdgeInsets.all(10),
                  onPressed: this.onPressedRemover,
                  child: Icon(Icons.delete,color: Colors.white,),
                ),
              ),
            //Button Remove
            ],
          ),
        )
      ),
    );
  }
}
