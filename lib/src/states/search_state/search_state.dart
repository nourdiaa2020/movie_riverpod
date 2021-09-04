import 'package:flutter/material.dart';
import 'package:movie_app_riverpod/src/models/movie.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {
  final List<Movie> movies;

  SearchInitial(this.movies);

}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {
  final String err;

  SearchError(this.err);
}

