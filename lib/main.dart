import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc_lib/screens/albums_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // someFutureResult().then((dynamic result) => print('$result'));
  // print("you should see me first");
  // Message message = Message(id: "ok", content: "info");
  // print(message.id);
}

// class Message {
//   String id;
//   String content;
//
//   Message({@required this.id, @required this.content}) {
//     assert(id != null);
//     assert(content != null);
//   }
// }
//
// Future<dynamic> someFutureResult(){
//   final c = new Completer();
//   // complete will be called in 3 seconds by the timer.
//   new Timer(Duration(seconds: 3), () {
//     print("Yeah, this line is printed after 3 seconds");
//     c.complete("you should see me final");
//   });
//   return c.future;
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: AlbumsScreen.screen(),
      );
  }
}




