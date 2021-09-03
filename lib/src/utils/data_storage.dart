import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataStorage {
  static Future saveOrDeleteFavorite(Movie data) async {
    final instance = GetIt.instance.get<SharedPreferences>();
    if (isInFavorite(data.id)) {
      delFavorite(data);
    } else {
      await instance.setString(data.id.toString(), jsonEncode(data.toMap()));
    }
  }

  static Future delFavorite(Movie data) async {
    final instance = GetIt.instance.get<SharedPreferences>();
    await instance.remove(data.id.toString());
  }

  static List<Movie> allFavorite() {
    final instance = GetIt.instance.get<SharedPreferences>();
    final keys = instance.getKeys();
    final list = <Movie>[];
    for (final k in keys) {
      final value = instance.getString(k).toString();
      list.add(Movie.fromMap(jsonDecode(value)));
    }
    return list;
  }

  static bool isInFavorite(int id) {
    final instance = GetIt.instance.get<SharedPreferences>();
    return instance.get(id.toString()) != null;
  }
}
