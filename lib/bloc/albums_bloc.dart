
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lib/bloc/abums_states.dart';
import 'package:flutter_bloc_lib/bloc/albums_events.dart';
import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:flutter_bloc_lib/network_error/internet_error.dart';
import 'package:flutter_bloc_lib/repository/repository.dart';
import 'package:flutter_bloc_lib/settings/app_themes.dart';

class AlbumsBloc extends Bloc<AlbumsEvents, AlbumsState>{
  final AlbumsRepo albumsRepo;
  List<Albums> albums;

  AlbumsBloc({this.albumsRepo}) : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvents event) async*{

    switch(event){
      case AlbumsEvents.fetchAlbums:
        yield AlbumsLoading();
        try{
          albums = await albumsRepo.getAlbumsList();
          yield AlbumsLoaded(albums: albums);
        } on SocketException{
          yield AlbumsListError(error: NoInternetException('No Internet'));
        } on HttpException{
          yield AlbumsListError(error: NoServiceFoundException('No Service found'));
        } on FormatException{
          yield AlbumsListError(error: InvalidFormatException('Invalid Responce format'));
        } catch(e){
          yield AlbumsListError(error: UnknownException('Unknown error'));
        }
        break;
    }
  }

}