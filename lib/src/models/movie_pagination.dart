import 'package:flutter/foundation.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';

class MoviePagination {
  final List<Movie> movies;
  final int page;
  final String errorMessage;

  MoviePagination({
    required this.movies,
    required this.page,
    required this.errorMessage,
  });


  MoviePagination.initial()
      : movies = [],
        page = 1,
        errorMessage = '';

  bool get refreshError => errorMessage != '' && movies.length <= 20;

  @override
  String toString() =>
      'MoviePagination(movies: $movies, page: $page, errorMessage: $errorMessage)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MoviePagination &&
        listEquals(o.movies, movies) &&
        o.page == page &&
        o.errorMessage == errorMessage;
  }

  @override
  int get hashCode => movies.hashCode ^ page.hashCode ^ errorMessage.hashCode;

  MoviePagination copyWith({
    List<Movie>? movies,
    int? page,
    String? errorMessage,
  }) {
    return MoviePagination(
      movies: movies ?? this.movies,
      page: page ?? this.page,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
