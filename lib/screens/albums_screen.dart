import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lib/bloc/abums_states.dart';
import 'package:flutter_bloc_lib/bloc/albums_bloc.dart';
import 'package:flutter_bloc_lib/bloc/albums_events.dart';
import 'package:flutter_bloc_lib/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc_lib/bloc/theme/theme_event.dart';
import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:flutter_bloc_lib/repository/repository.dart';
import 'package:flutter_bloc_lib/settings/app_themes.dart';
import 'package:flutter_bloc_lib/settings/preferences.dart';
import 'package:flutter_bloc_lib/widgets/error.dart';
import 'package:flutter_bloc_lib/widgets/list_row.dart';
import 'package:flutter_bloc_lib/widgets/loading.dart';
import 'package:flutter_bloc_lib/widgets/txt.dart';

class AlbumsScreen extends StatefulWidget {
  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}
class _AlbumsScreenState extends State<AlbumsScreen> {
  //
  @override
  void initState() {
    super.initState();
    _loadTheme();
    _loadAlbums();
  }

  void _loadTheme() {
    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(appThemes: Preferences.getTheme()));
  }

  _loadAlbums() async {
    BlocProvider.of<AlbumsBloc>(context).add(AlbumsEvents.fetchAlbums);
  }

  _setTheme(bool dartTheme) async{
    AppTheme selectedTheme = dartTheme ? AppTheme.lightTheme : AppTheme.darkTheme;
    BlocProvider.of<ThemeBloc>(context).add(ThemeEvent(appThemes: selectedTheme));
    Preferences.saveTheme(selectedTheme);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Txt(text: 'Albums'),
        actions: [
          Switch(
              value: Preferences.getTheme() == AppTheme.lightTheme,
              onChanged: (va1) {
                _setTheme(va1);
              })
        ],
      ),
      body: Container(
        child: _body(),
      ),
    );
  }
  _body() {
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
              if (state is AlbumsListError) {
                final error = state.error;
                String message = '${error.message}\nTap to Retry.';
                return ErrorTxt(
                  message: message,
                  onTap: _loadAlbums,
                );
              }
              if (state is AlbumsLoaded) {
                List<Albums> albums = state.albums;
                return _list(albums);
              }
              return Loading();
            }),
      ],
    );
  }
  Widget _list(List<Albums> albums) {
    return Expanded(
      child: ListView.builder(
        itemCount: albums.length,
        itemBuilder: (_, index) {
          Albums album = albums[index];
          return ListRow(albums: album);
        },
      ),
    );
  }


}