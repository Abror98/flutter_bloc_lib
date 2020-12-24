
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_lib/model/albums.dart';

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
}

class AlbumsListError extends AlbumsState{
  final error;
  AlbumsListError({this.error});
}