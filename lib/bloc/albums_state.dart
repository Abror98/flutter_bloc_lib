part of 'albums_bloc.dart';

abstract class AlbumsState extends Equatable{

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AlbumsInitState extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsLoaded extends AlbumsState{
  final List<Albums> albums;
  AlbumsLoaded({this.albums});

  @override
  // TODO: implement props
  List<Object> get props => [albums];
}

class AlbumsCountState extends AlbumsState {
  final count;

  AlbumsCountState({this.count});
}

class AlbumsListError extends AlbumsState{
  final error;
  AlbumsListError({this.error});
}
