import 'package:movie_app_riverpod/src/utils/config.dart';
import 'package:movie_app_riverpod/src/utils/data_storage.dart';

class Movie {
  final int id;
  final String title;
  final String desc;
  final String posterPath;
    bool isInFavorite;
  final String shareLinkUrl;

//<editor-fold desc="Data Methods">

    Movie({
    required this.id,
    required this.title,
    required this.desc,
    required this.posterPath,
    required this.isInFavorite,
    required this.shareLinkUrl,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Movie &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          desc == other.desc);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ desc.hashCode;

  @override
  String toString() {
    return 'Movie{' + ' id: $id,' + ' title: $title,' + ' desc: $desc,' + '}';
  }

  Movie copyWith({
    int? id,
    String? title,
    String? desc,
    String? posterPath,
    bool? isInFavorite,
    String? shareLinkUrl,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      desc: desc ?? this.desc,
      posterPath: posterPath ?? this.posterPath,
      isInFavorite: isInFavorite ?? this.isInFavorite,
      shareLinkUrl: shareLinkUrl ?? this.shareLinkUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'original_title': this.desc,
      'poster_path': this.posterPath,
      'isInFavorite': DataStorage.isInFavorite(this.id),
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
        id: map['id'] as int,
        title: map['title'] as String,
        desc: map['original_title'] as String,
        posterPath: "${KImageApiBaseUrl}${map['poster_path'].toString()}",
        isInFavorite: DataStorage.isInFavorite(map['id'] as int),
        shareLinkUrl: KApiBaseUrl + map['id'].toString());
  }

//</editor-fold>
}
