import 'dart:convert';

import 'package:http/http.dart';
import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:storify/models/playlist.dart';
import 'package:storify/models/user.dart';
import 'package:storify/services/api_path.dart';
import 'package:storify/services/spotify_interceptor.dart';

class SpotifyApi {
  static Client client = HttpClientWithInterceptor.build(interceptors: [
    SpotifyInterceptor(),
  ], retryPolicy: ExpiredTokenRetryPolicy());

  static Future<User> getCurrentUser() async {
    final response = await client.get(
      APIPath.getCurrentUser,
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to get user with status code ${response.statusCode}');
    }
  }

  static Future<User> getUserById(String userId) async {
    final response = await client.get(
      APIPath.getUserById(userId),
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to get user with status code ${response.statusCode}');
    }
  }

  static Future<List<Playlist>> getListOfPlaylists() async {
    final response = await client.get(APIPath.getListOfPlaylists);

    if (response.statusCode == 200) {
      List items = json.decode(response.body)['items'];
      items = await Future.wait(items.map((item) => client
              .get(
            APIPath.getUserById(item['owner']['id']),
          )
              .then((response) {
            item['owner'] = json.decode(response.body);
            return item;
          })));

      return items.map((item) {
        return Playlist.fromJson(item);
      }).toList();
    } else {
      throw Exception(
          'Failed to get list of playlists with status code ${response.statusCode}');
    }
  }
}
