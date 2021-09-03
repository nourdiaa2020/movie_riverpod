import 'package:movie_app_riverpod/src/utils/config.dart';

class MovieDetailModel {
  final bool adult;
  final String backdropPath;
  final int budget;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String countryName;

//<editor-fold desc="Data Methods">

 const MovieDetailModel({
    required this.adult,
    required this.backdropPath,
    required this.budget,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.countryName,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

 @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieDetailModel &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          backdropPath == other.backdropPath &&
          budget == other.budget &&
          homepage == other.homepage &&
          id == other.id &&
          imdbId == other.imdbId &&
          originalLanguage == other.originalLanguage &&
          originalTitle == other.originalTitle &&
          overview == other.overview &&
          popularity == other.popularity &&
          posterPath == other.posterPath &&
          releaseDate == other.releaseDate &&
          revenue == other.revenue &&
          runtime == other.runtime &&
          status == other.status &&
          tagline == other.tagline &&
          title == other.title &&
          video == other.video &&
          voteAverage == other.voteAverage &&
          voteCount == other.voteCount);

 @override
  int get hashCode =>
      adult.hashCode ^
      backdropPath.hashCode ^
      budget.hashCode ^
      homepage.hashCode ^
      id.hashCode ^
      imdbId.hashCode ^
      originalLanguage.hashCode ^
      originalTitle.hashCode ^
      overview.hashCode ^
      popularity.hashCode ^
      posterPath.hashCode ^
      releaseDate.hashCode ^
      revenue.hashCode ^
      runtime.hashCode ^
      status.hashCode ^
      tagline.hashCode ^
      title.hashCode ^
      video.hashCode ^
      voteAverage.hashCode ^
      voteCount.hashCode;

 @override
  String toString() {
    return 'MovieDetailModel{' +
        ' adult: $adult,' +
        ' backdropPath: $backdropPath,' +
        ' budget: $budget,' +
        ' homepage: $homepage,' +
        ' id: $id,' +
        ' imdbId: $imdbId,' +
        ' originalLanguage: $originalLanguage,' +
        ' originalTitle: $originalTitle,' +
        ' overview: $overview,' +
        ' popularity: $popularity,' +
        ' posterPath: $posterPath,' +
        ' releaseDate: $releaseDate,' +
        ' revenue: $revenue,' +
        ' runtime: $runtime,' +
        ' status: $status,' +
        ' tagline: $tagline,' +
        ' title: $title,' +
        ' video: $video,' +
        ' voteAverage: $voteAverage,' +
        ' voteCount: $voteCount,' +
        '}';
  }



 Map<String, dynamic> toMap() {
    return {
      'adult': this.adult,
      'backdropPath': this.backdropPath,
      'budget': this.budget,
      'homepage': this.homepage,
      'id': this.id,
      'imdbId': this.imdbId,
      'originalLanguage': this.originalLanguage,
      'originalTitle': this.originalTitle,
      'overview': this.overview,
      'popularity': this.popularity,
      'posterPath': this.posterPath,
      'releaseDate': this.releaseDate,
      'revenue': this.revenue,
      'runtime': this.runtime,
      'status': this.status,
      'tagline': this.tagline,
      'title': this.title,
      'video': this.video,
      'voteAverage': this.voteAverage,
      'voteCount': this.voteCount,
    };
  }

  factory MovieDetailModel.fromMap(Map<String, dynamic> map) {
    return MovieDetailModel(
      adult: map['adult'] as bool,
      backdropPath: map['backdrop_path'] as String,
      budget: map['budget'] as int,
      homepage: map['homepage'] as String,
      id: map['id'] as int,
      imdbId: map['imdb_id'] as String,
      originalLanguage: map['original_language'] as String,
      originalTitle: map['original_title'] as String,
      overview: map['overview'] as String,
      popularity: map['popularity'] as double,
      posterPath: KImageApiBaseUrl+map['poster_path'],
      releaseDate: map['release_date'] as String,
      revenue: map['revenue'] as int,
      runtime: map['runtime'] as int,
      status: map['status'] as String,
      tagline: map['tagline'] as String,
      title: map['title'] as String,
      video: map['video'] as bool,
      countryName: map['production_countries'][0]['iso_3166_1']  ,
      voteAverage: map['vote_average'] as double,
      voteCount: map['vote_count'] as int,
    );
  }

//</editor-fold>
}
