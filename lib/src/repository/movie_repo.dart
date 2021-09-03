import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final movieServiceProvider = Provider<MovieRepo>((ref) {
  return MovieRepo();
});

class MovieRepo {
  Future<List<Movie>> getMovies([int page = 1]) async {
    final listOfMaps = (await CustomDio().send(
            reqMethod: "Get",
            path: "movie/popular",
            query: {"api_key": KApiKey, "language": "en-US", "page": page}))
        .data['results'] as List;
    // log(listOfMaps.toString());
    return listOfMaps.map((e) => Movie.fromMap(e)).toList();
  }
}
