import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lib/bloc/albums_bloc.dart';
import 'package:flutter_bloc_lib/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc_lib/bloc/theme/theme_state.dart';
import 'package:flutter_bloc_lib/repository/repository.dart';
import 'package:flutter_bloc_lib/screens/albums_screen.dart';
import 'package:flutter_bloc_lib/settings/preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, ThemeState themeState){
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: BlocProvider(
              create: (context) => AlbumsBloc(albumsRepo: AlbumsRepository()),
              child: AlbumsScreen(),
            ),
          );
    },
      ),
    );
  }
}


