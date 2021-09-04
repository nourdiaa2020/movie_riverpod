import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/genre_model.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final movieServiceProvider = Provider<MovieRepo>((ref) {
  return MovieRepo();
});

// final homeDataProvider = FutureProvider<MovieRepo>((ref) async {
//   final repo = ref.watch(movieServiceProvider);
//   final recent = await repo.getRecentMovie();
//   final gen = await repo.getGenres();
//   final movieByGenreId = await repo.getMovieByGenreId(gen.first.id);
//
// });

final homeRecentProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieServiceProvider);
  return await repo.getRecentMovie();
});

final homeGenericProvider = FutureProvider<List<GenreModel>>((ref) async {
  final repo = ref.watch(movieServiceProvider);
  return await repo.getGenres();
});

final homeMovieProvider =
    FutureProvider.family<List<Movie>, int>((ref, id) async {
  final repo = ref.watch(movieServiceProvider);
  return await repo.getMovieByGenreId(id);
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

  Future<List<Movie>> getRecentMovie() async {
    final listOfMaps = (await CustomDio().send(
            reqMethod: "Get",
            path: "movie/upcoming",
            query: {"api_key": KApiKey, "language": "en-US"}))
        .data['results'] as List;
    // log(listOfMaps.toString());
    return listOfMaps.map((e) => Movie.fromMap(e)).toList();
  }

  Future<List<GenreModel>> getGenres() async {
    final listOfMaps = (await CustomDio().send(
            reqMethod: "Get",
            path: "genre/movie/list",
            query: {"api_key": KApiKey, "language": "en-US"}))
        .data['genres'] as List;
    //log(listOfMaps.toString());
    return listOfMaps.map((e) => GenreModel.fromMap(e)).toList();
  }

  Future<List<Movie>> getMovieByGenreId(int id) async {
    final listOfMaps = (await CustomDio().send(
            reqMethod: "Get",
            path: "discover/movie",
            query: {
          "api_key": KApiKey,
          "language": "en-US",
          "with_genres": id
        }))
        .data['results'] as List;
    return listOfMaps.map((e) => Movie.fromMap(e)).toList();
  }
}
