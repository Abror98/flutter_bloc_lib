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

class AlbumsBloc extends Bloc<AlbumsEvents, AlbumsState> {
  AlbumsRepository _albumsRepository = AlbumsRepository();
  List<Albums> _albums;
  int _count = 0;

  AlbumsBloc() : super(AlbumsInitState());

  @override
  Stream<AlbumsState> mapEventToState(AlbumsEvents event) async* {
    if (event is AlbumsLoadEvent)
      yield* _loadFunc(event);
    else if (event is AlbumsAddEvent)
      yield* _addFunc(event);
    else if (event is AlbumsDecrementEvent) yield* _decrementFunc(event);
  }

  Stream<AlbumsState> _loadFunc(AlbumsLoadEvent event) async* {
    yield AlbumsLoadingState();
    try {
      _albums = await _albumsRepository.getAlbumsList();
      yield AlbumsLoadedState(albums: _albums,count: _count);
    } on SocketException {
      yield AlbumsListErrorState(error: NoInternetException('No Internet'));
    } on HttpException {
      yield AlbumsListErrorState(error: NoServiceFoundException('No Service found'));
    } on FormatException {
      yield AlbumsListErrorState(
          error: InvalidFormatException('Invalid Responce format'));
    } catch (e) {
      yield AlbumsListErrorState(error: UnknownException('Unknown error'));
    }
  }

  Stream<AlbumsState> _addFunc(AlbumsAddEvent event) async* {
    ++_count;
    yield AlbumsLoadedState(albums: _albums, count: _count);
    //yield AlbumsCountState(count: count);
  }

  Stream<AlbumsState> _decrementFunc(AlbumsDecrementEvent event) async* {
    --_count;
    yield AlbumsLoadedState(albums: _albums, count: _count);
    //yield AlbumsCountState(count: count);
  }
}
