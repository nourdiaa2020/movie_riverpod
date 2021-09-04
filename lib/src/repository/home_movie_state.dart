import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final homeMovieState = StateNotifierProvider<HomeMovieState, List<Movie>>(
    (ref) => HomeMovieState()..getDataById(28));

class HomeMovieState extends StateNotifier<List<Movie>> {
  HomeMovieState() : super([]);

  Future getDataById(int id) async {
    state = [];
    final listOfMaps = (await CustomDio().send(
            reqMethod: "Get",
            path: "discover/movie",
            query: {
          "api_key": KApiKey,
          "language": "en-US",
          "with_genres": id
        }))
        .data['results'] as List;
    state = listOfMaps.map((e) => Movie.fromMap(e)).toList();
  }
}
