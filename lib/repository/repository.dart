import 'package:flutter_bloc_lib/model/albums.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class AlbumsRepository{
  static const _baseUrl = 'jsonplaceholder.typicode.com';
  static const String _GET_ALBUMS = '/albums';

  @override
  Future<List<Albums>> getAlbumsList() async{
     Uri uri = Uri.https(_baseUrl, _GET_ALBUMS);
     Response response = await http.get(uri).timeout(Duration(seconds: 10));
     List<Albums> albums = albumsFromJson(response.body);
     return albums;
  }
}