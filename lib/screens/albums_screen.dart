import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_lib/bloc/albums_bloc.dart';
import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:flutter_bloc_lib/widgets/error.dart';
import 'package:flutter_bloc_lib/widgets/list_row.dart';
import 'package:flutter_bloc_lib/widgets/loading.dart';
import 'package:flutter_bloc_lib/widgets/txt.dart';

class AlbumsScreen extends StatefulWidget {
  static Widget screen() => BlocProvider(
        create: (context) => AlbumsBloc(),
        child: AlbumsScreen(),
      );

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  AlbumsBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<AlbumsBloc>(context);
    bloc.add(AlbumsLoadEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Txt(text: 'Albums'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return BlocBuilder<AlbumsBloc, AlbumsState>(builder: (context, state) {
      if (state is AlbumsLoadingState || state is AlbumsInitState)
        return Center(child: CircularProgressIndicator());
      if (state is AlbumsListErrorState) return Center(child: Text("${state.error}"));
      if (state is AlbumsLoadedState)
        return Column(
          children: [
            Row(
              children: [
                MaterialButton(
                  minWidth: 50,
                  height: 50,
                  shape: CircleBorder(),
                  color: Colors.blue,
                  onPressed: () => bloc.add(AlbumsAddEvent()),
                  child: Icon(Icons.add, color: Colors.white),
                ),
                Text("${state.count}"),
                MaterialButton(
                  minWidth: 50,
                  height: 50,
                  shape: CircleBorder(),
                  color: Colors.blue,
                  onPressed: () => bloc.add(AlbumsDecrementEvent()),
                  child: Icon(Icons.remove, color: Colors.white),
                ),
              ],
            ),
            _list(state.albums),
          ],
        );
      throw Exception("$state uchun widget topilmadi");
    });
    return Column(
      children: [
        BlocBuilder<AlbumsBloc, AlbumsState>(
          builder: (context, state) {
            // if (state is AlbumsCountState)
            //   return SizedBox(
            //     height: 100,
            //     child: Row(
            //       children: [
            //         MaterialButton(
            //           onPressed: () {
            //             bloc.add(AlbumsDecrementEvent());
            //           },
            //           child: Text("Decrement"),
            //         ),
            //         Text(state.count.toString()),
            //         MaterialButton(
            //           onPressed: () {
            //             bloc.add(AlbumsAddEvent());
            //           },
            //           child: Text("Increment"),
            //         ),
            //       ],
            //     ),
            //   );
            return SizedBox(
              height: 100,
              child: Row(
                children: [
                  MaterialButton(
                      onPressed: () {
                        bloc.add(AlbumsDecrementEvent());
                      },
                      child: Text("Decrement")),
                  Text(''),
                  MaterialButton(
                    onPressed: () {
                      bloc.add(AlbumsAddEvent());
                    },
                    child: Text("Increment"),
                  ),
                ],
              ),
            );
          },
        ),
        BlocBuilder<AlbumsBloc, AlbumsState>(
            builder: (BuildContext context, AlbumsState state) {
          if (state is AlbumsListErrorState) {
            final error = state.error;
            String message = '${error.message}\nTap to Retry.';
            return ErrorTxt(message: message);
          }
          if (state is AlbumsLoadedState) {
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
