import 'package:flutter/material.dart';
import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:flutter_bloc_lib/widgets/txt.dart';

class ListRow extends StatelessWidget{
 final Albums albums;

 ListRow({this.albums});

  @override
  Widget build(BuildContext context) {
     return Container(
       padding: EdgeInsets.all(20.0),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Txt(text: albums.title),
           Divider(),
         ],
       ),
     );
  }
}