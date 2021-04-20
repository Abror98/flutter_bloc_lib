import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:flutter_bloc_lib/network_error/internet_error.dart';
import 'package:flutter_bloc_lib/repository/repository.dart';
import 'package:meta/meta.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvents, AlbumsState>{
  AlbumsRepository albumsRepository = AlbumsRepository();
  List<Albums> albums;
  int count = 0;

  AlbumsBloc() : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvents event) async*{
    if(event is AlbumsLoadEvent)
      yield* loadFunc(event);
    if(event is AlbumsAddEvent)
      yield* addFunc(event);
    if(event is AlbumsDecrementEvent)
      yield* decrementFunc(event);
  }

  Stream<AlbumsState> loadFunc(AlbumsLoadEvent event) async* {
    yield AlbumsLoading();
    try{
      albums = await albumsRepository.getAlbumsList();
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
  }

  Stream<AlbumsState> addFunc(AlbumsAddEvent event) async* {
    ++count;
    yield AlbumsCountState(count: count);
  }

  Stream<AlbumsState> decrementFunc(AlbumsDecrementEvent event) async* {
    --count;
    yield AlbumsCountState(count: count);
  }


}