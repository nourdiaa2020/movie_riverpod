import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app_riverpod/src/models/movie_pagination.dart';
import 'package:movie_app_riverpod/src/repository/movie_repo.dart';
import 'package:movie_app_riverpod/src/utils/data_storage.dart';

final moviePaginationControllerProvider =
    StateNotifierProvider<MoviePaginationController, MoviePagination>((ref) {
  final movieService = ref.read(movieServiceProvider);
  return MoviePaginationController(movieService);
});

class MoviePaginationController extends StateNotifier<MoviePagination> {
  MoviePaginationController(
    this._movieRepo, [
    MoviePagination? state,
  ]) : super(state ?? MoviePagination.initial()) {
    getMovies();
  }

  final MovieRepo _movieRepo;

  Future<void> getMovies() async {
    try {
      final movies = await _movieRepo.getMovies(state.page);

      state = state
          .copyWith(movies: [...state.movies, ...movies], page: state.page + 1);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> refreshMovies(final int id) async {
    try {
      final isInFav = DataStorage.isInFavorite(id);
      final e = state.movies.firstWhere((element) => element.id == id);
      e.isInFavorite = isInFav;
    } catch (err) {}
  }

  void handleScrollWithIndex(int index) {
    final itemPosition = index + 1;
    final requestMoreData = itemPosition % 20 == 0 && itemPosition != 0;
    final pageToRequest = itemPosition ~/ 20;

    if (requestMoreData && pageToRequest + 1 >= state.page) {
      getMovies();
    }
  }
}
