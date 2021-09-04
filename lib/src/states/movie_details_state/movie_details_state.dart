

import 'package:flutter/cupertino.dart';
import 'package:movie_app_riverpod/src/models/movie_detail_model.dart';

@immutable
abstract class MovieDetailsState {}

class MovieDetailsLoaded extends MovieDetailsState {
  final MovieDetailModel model;
  MovieDetailsLoaded(this.model);
}

class MovieDetailsLoading extends MovieDetailsState {
}

class MovieDetailsError extends MovieDetailsState {
  final String err;

  MovieDetailsError(this.err);
}
