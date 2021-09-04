import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie_detail_model.dart';
import 'package:movie_app_riverpod/src/states/movie_details_state/movie_details_state.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

// final getMovieByIdProvider =
//     FutureProvider.autoDispose.family<MovieDetailModel, int>((ref, id) async {
//   final res = (await CustomDio().send(
//     reqMethod: "Get",
//     path: "movie/$id",
//     query: {"api_key": KApiKey},
//   ))
//       .data;
//   return MovieDetailModel.fromMap(res);
// });

final homeMovieState =
    StateNotifierProvider.autoDispose<MovieDetailController, MovieDetailsState>(
        (ref) => MovieDetailController());

class MovieDetailController extends StateNotifier<MovieDetailsState> {
  MovieDetailController() : super(MovieDetailsLoading());

  Future<void> getMovieData(int movieId) async {
    state = MovieDetailsLoading();
    final res = (await CustomDio().send(
      reqMethod: "Get",
      path: "movie/$movieId",
      query: {"api_key": KApiKey},
    ))
        .data;
    state = MovieDetailsLoaded(MovieDetailModel.fromMap(res));
  }

  void changeLike(int id) {
    (state as MovieDetailsLoaded).model.isInFavorite =
        !(state as MovieDetailsLoaded).model.isInFavorite;
    state = MovieDetailsLoaded((state as MovieDetailsLoaded).model);
  }
}
