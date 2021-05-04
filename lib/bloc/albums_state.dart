part of 'albums_bloc.dart';

abstract class AlbumsState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumsState {}

class AlbumsLoadingState extends AlbumsState {}

class AlbumsLoadedState extends AlbumsState {
  final List<Albums> albums;
  final int count;

  AlbumsLoadedState({this.albums, this.count});

  @override
  List<Object> get props => [albums, count];
}


class AlbumsListErrorState extends AlbumsState {
  final error;

  AlbumsListErrorState({this.error});
}
