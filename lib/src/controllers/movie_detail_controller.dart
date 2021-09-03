import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie_detail_model.dart';
import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/dio_utils/custom_dio.dart';

final getMovieByIdProvider =
    FutureProvider.autoDispose.family<MovieDetailModel, int>((ref, id) async {
  final res = (await CustomDio().send(
    reqMethod: "Get",
    path: "movie/$id",
    query: {"api_key": KApiKey},
  ))
      .data;
  return MovieDetailModel.fromMap(res);
});

class MovieDetailController extends StateNotifier<MovieDetailModel> {
  MovieDetailController(MovieDetailModel state) : super(state);

// Future<void> getMovieData(int movieId) async {
//   final listOfMaps = (await CustomDio().send(
//           reqMethod: "Get",
//           path: "movie/$movieId",
//           query: {"api_key": KApiKey}))
//       .data;
//
//   log(jsonEncode(listOfMaps).toString());
//
//   //  state =
// }
}
